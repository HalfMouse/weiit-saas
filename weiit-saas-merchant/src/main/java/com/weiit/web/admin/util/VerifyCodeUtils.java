package com.weiit.web.admin.util;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.Random;

public class VerifyCodeUtils {
	
	//使用到Algerian字体，系统里没有的话需要安装字体，字体只显示大写，去掉了1,0,i,o几个容易混淆的字符
	public static final String VERIFY_CODES = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
//	public static final String VERIFY_CODES = "0123456789";
	private static Random random = new Random();


	/**
	 * 使用系统默认字符源生成验证码
	 * @param verifySize	验证码长度
	 * @return
	 */
	public static String generateVerifyCode(int verifySize){
		return generateVerifyCode(verifySize, VERIFY_CODES);
	}
	/**
	 * 使用指定源生成验证码
	 * @param verifySize	验证码长度
	 * @param sources	验证码字符源
	 * @return
	 */
	public static String generateVerifyCode(int verifySize, String sources){
		if(sources == null || sources.length() == 0){
			sources = VERIFY_CODES;
		}
		int codesLen = sources.length();
		Random rand = new Random(System.currentTimeMillis());
		StringBuilder verifyCode = new StringBuilder(verifySize);
		for(int i = 0; i < verifySize; i++){
			verifyCode.append(sources.charAt(rand.nextInt(codesLen-1)));
		}
		return verifyCode.toString();
	}
	
	/**
	 * 生成随机验证码文件,并返回验证码值
	 * @param w
	 * @param h
	 * @param outputFile
	 * @param verifySize
	 * @return
	 * @throws IOException
	 */
	public static String outputVerifyImage(int w, int h, File outputFile, int verifySize) throws IOException{
		String verifyCode = generateVerifyCode(verifySize);
		outputImage(w, h, outputFile, verifyCode);
		return verifyCode;
	}
	
	/**
	 * 输出随机验证码图片流,并返回验证码值
	 * @param w
	 * @param h
	 * @param os
	 * @param verifySize
	 * @return
	 * @throws IOException
	 */
	public static String outputVerifyImage(int w, int h, OutputStream os, int verifySize) throws IOException{
		String verifyCode = generateVerifyCode(verifySize);
		outputImage(w, h, os, verifyCode);
		return verifyCode;
	}
	
	/**
	 * 生成指定验证码图像文件
	 * @param w
	 * @param h
	 * @param outputFile
	 * @param code
	 * @throws IOException
	 */
	public static void outputImage(int w, int h, File outputFile, String code) throws IOException{
		if(outputFile == null){
			return;
		}
		File dir = outputFile.getParentFile();
		if(!dir.exists()){
			dir.mkdirs();
		}
		try{
			outputFile.createNewFile();
			FileOutputStream fos = new FileOutputStream(outputFile);
			outputImage(w, h, fos, code);
			fos.close();
		} catch(IOException e){
			throw e;
		}
	}

	public static void outputImage(int w, int h, HttpServletResponse response, String code) throws IOException{
		outputImage(w,h,response.getOutputStream(),code);
	}
	
	/**
	 * 输出指定验证码图片流
	 * @param w
	 * @param h
	 * @param os
	 * @param code
	 * @throws IOException
	 */
	public static void outputImage(int w, int h, OutputStream os, String code) throws IOException{
		int verifySize = code.length();
		BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		Random rand = new Random();
		Graphics2D g2 = image.createGraphics();
		g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
		Color[] colors = new Color[5];
		Color[] colorSpaces = new Color[] { Color.WHITE, Color.CYAN,
				Color.GRAY, Color.LIGHT_GRAY, Color.MAGENTA, Color.ORANGE,
				Color.PINK, Color.YELLOW };
		float[] fractions = new float[colors.length];
		for(int i = 0; i < colors.length; i++){
			colors[i] = colorSpaces[rand.nextInt(colorSpaces.length)];
			fractions[i] = rand.nextFloat();
		}
		Arrays.sort(fractions);
		
		g2.setColor(Color.GRAY);// 设置边框色
		g2.fillRect(0, 0, w, h);
		
		Color c = getRandColor(200, 250);
		g2.setColor(c);// 设置背景色
		g2.fillRect(0, 2, w, h-4);
		
		//绘制干扰线
//		Random random = new Random();
//		g2.setColor(getRandColor(100, 160));// 设置线条的颜色
//		for (int i = 0; i < 200; i++) {
//			int x = random.nextInt(w - 1);
//			int y = random.nextInt(h - 1);
//			int xl = random.nextInt(6) + 1;
//			int yl = random.nextInt(12) + 1;
//			g2.drawLine(x, y, x + xl + 40, y + yl + 20);
//		}
		
		// 添加噪点
//		float yawpRate = 0.05f;// 噪声率
//		int area = (int) (yawpRate * w * h);
//		for (int i = 0; i < area; i++) {
//			int x = random.nextInt(w);
//			int y = random.nextInt(h);
//			int rgb = getRandomIntColor();
//			image.setRGB(x, y, rgb);
//		}
		
		//shear(g2, w, h, c);// 使图片扭曲


		int fontSize = h-4;
		Font font = new Font("Algerian", Font.ITALIC, fontSize);
		g2.setFont(font);
		char[] chars = code.toCharArray();
		for(int i = 0; i < verifySize; i++){
			g2.setColor(getRandColor(100, 160));

			AffineTransform affine = new AffineTransform();
			affine.setToRotation(Math.PI / 4 * rand.nextDouble() * (rand.nextBoolean() ? 1 : -1), (w / verifySize) * i + fontSize/2, h/2);
			g2.setTransform(affine);
			g2.drawChars(chars, i, 1, ((w-10) / verifySize) * i + 5, h/2 + fontSize/2 - 10);
		}
		
		g2.dispose();


		//ImageIO.write(image, "jpg", os);
		ImageIO.write(twistImage(image), "jpg", os);
	}
	
	private static Color getRandColor(int fc, int bc) {
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}
	
	private static int getRandomIntColor() {
		int[] rgb = getRandomRgb();
		int color = 0;
		for (int c : rgb) {
			color = color << 8;
			color = color | c;
		}
		return color;
	}
	
	private static int[] getRandomRgb() {
		int[] rgb = new int[3];
		for (int i = 0; i < 3; i++) {
			rgb[i] = random.nextInt(255);
		}
		return rgb;
	}

	private static void shear(Graphics g, int w1, int h1, Color color) {
		shearX(g, w1, h1, color);
		shearY(g, w1, h1, color);
	}
	
	private static void shearX(Graphics g, int w1, int h1, Color color) {

		int period = random.nextInt(2);

		boolean borderGap = true;
		int frames = 1;
		int phase = random.nextInt(2);

		for (int i = 0; i < h1; i++) {
			double d = (double) (period >> 1)
					* Math.sin((double) i / (double) period
							+ (6.2831853071795862D * (double) phase)
							/ (double) frames);
			g.copyArea(0, i, w1, 1, (int) d, 0);
			if (borderGap) {
				g.setColor(color);
				g.drawLine((int) d, i, 0, i);
				g.drawLine((int) d + w1, i, w1, i);
			}
		}

	}

	private static void shearY(Graphics g, int w1, int h1, Color color) {

		int period = random.nextInt(40) + 10; // 50;

		boolean borderGap = true;
		int frames = 20;
		int phase = 7;
		for (int i = 0; i < w1; i++) {
			double d = (double) (period >> 1)
					* Math.sin((double) i / (double) period
							+ (6.2831853071795862D * (double) phase)
							/ (double) frames);
			g.copyArea(i, 0, 1, h1, 0, (int) d);
			if (borderGap) {
				g.setColor(color);
				g.drawLine(i, (int) d, i, 0);
				g.drawLine(i, (int) d + h1, i, h1);
			}

		}

	}

	public static BufferedImage twistImage(BufferedImage srcImage) {
		double dMultValue = random.nextInt(7) + 3;// 波形的幅度倍数，越大扭曲的程序越高，一般为3
		double dPhase = random.nextInt(6);// 波形的起始相位，取值区间（0-2＊PI）

		BufferedImage destBi = new BufferedImage(srcImage.getWidth(),
				srcImage.getHeight(), BufferedImage.TYPE_INT_RGB);

		for (int i = 0; i < destBi.getWidth(); i++) {
			for (int j = 0; j < destBi.getHeight(); j++) {
				int nOldX = getXPosition4Twist(dPhase, dMultValue,
						destBi.getHeight(), i, j);
				int nOldY = j;
				if (nOldX >= 0 && nOldX < destBi.getWidth() && nOldY >= 0
						&& nOldY < destBi.getHeight()) {
					destBi.setRGB(nOldX, nOldY, srcImage.getRGB(i, j));
				}
			}
		}
		return destBi;
	}

	public static int getXPosition4Twist(double dPhase, double dMultValue,
								   int height, int xPosition, int yPosition) {
		//double PI = 3.1415926535897932384626433832799; // 此值越大，扭曲程度越大
		double PI = 4.5;
		double dx = (double) (PI * yPosition) / height + dPhase;
		double dy = Math.sin(dx);
		return xPosition + (int) (dy * dMultValue);
	}

	public static void main(String[] args) throws IOException{
		File dir = new File("E:\\image");
		int w = 200, h = 80;
		for(int i = 0; i < 10; i++){
			String verifyCode = generateVerifyCode(4);
			File file = new File(dir, verifyCode + ".jpg");
			outputImage(w, h, file, verifyCode);

		}
	}
}
