$(document).on('ready', function(){

  'use strict';


    //***** Side Menu *****//
  $('.side-menus li.menu-item-has-children > a').on('click',function(){
    $(this).parent().siblings().children('ul').slideUp();
    $(this).parent().siblings().removeClass('active');
    $(this).parent().children('ul').slideToggle();
    $(this).parent().toggleClass('active');
    return false;
  });

  //***** Side Menu Option *****//
  $('.menu-options').on('click', function(){
    $('.menu-options').toggleClass('active');
    $('.side-menu-sec').toggleClass('slide-out');
    $('.main-content').toggleClass('menu-slide');
  });

  /*================== Notifications Dropdown =====================*/
  $(".dropdown > span").on("click",function() {
    $(this).parent().find(".drop-list").toggleClass("active");
    return false;
  });
  $('html').on("click",function(){
    $('.drop-list').removeClass('active');
  });
  $(".drop-list,.dropdown").on("click",function(e){
    e.stopPropagation();
  });

  $('.search-dashboard .responsive-search').on('click', function(){
    $('.search-dashboard').toggleClass('active');
  });  

  //***** Clients lists Scroll *****//
  $('#header-scroll').slimScroll({
    height: '100%',
    wheelStep: 10,
    distance : '0px',
    color:'#878787',
    railOpacity : '0.1',
    size: '2px'
  });

  //***** Toggle Full Screen *****//
  function goFullScreen() {
    var
    el = document.documentElement
    , rfs =
    el.requestFullScreen
    || el.webkitRequestFullScreen
    || el.mozRequestFullScreen
    || el.msRequestFullscreen

    ;
    rfs.call(el);
  }
  $("#toolFullScreen").on("click",function() {
      goFullScreen();
  });


    //**** Slide Panel Toggle ***//
  $(".open-panel").on('click', function(){
     $(".slide-panel").addClass('active');
     $(".main-content").addClass('active');
  });

  $('.main-content').on("click",function(){
     $(".slide-panel").removeClass('active');
     $(this).removeClass('active');
  });

  $('.side-menus nav > ul > li.menu-item-has-children > ul > li > a').on('click', function(){
    if ($(window).width() < 979) {
      $('.side-menu-sec').removeClass('slide-out');
      $('.menu-options').removeClass('active');
    }
  }); 
      
  /* Copyright (c) 2013 ; Licensed  */
  //Sort by first name
  $(function() {
  $.fn.sortList = function() {
  var mylist = $(this);
  var listitems = $('li', mylist).get();
  listitems.sort(function(a, b) {
  var compA = $(a).text().toUpperCase();
  var compB = $(b).text().toUpperCase();
  return (compA < compB) ? -1 : 1;
  });
  $.each(listitems, function(i, itm) {
  mylist.append(itm);
  });
  }
  });

  //Sort by last name
  $(function() {
  $.fn.sortListLast = function() {
  var mylist = $(this);
  var listitems = $('li', mylist).get();
  listitems.sort(function(a, b) {
  var compA = $('.last-name', a).text().toUpperCase();
  var compB = $('.last-name', b).text().toUpperCase();
  return (compA < compB) ? -1 : 1;
  });
  $.each(listitems, function(i, itm) {
  mylist.append(itm);
  });
  }
  });

  //Search filter
  (function ($) {
  // custom css expression for a case-insensitive contains()
  jQuery.expr[':'].Contains = function(a,i,m){
  return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
  };


  function listFilter(searchDir, list) { 
  var form = $("<form>").attr({"class":"filterform","action":"#"}),
  input = $("<input>").attr({"class":"filterinput","type":"text","placeholder":"Live Search Mails"});
  $(form).append(input).appendTo(searchDir);

  $(input)
  .change( function () {
  var filter = $(this).val();
  if(filter) {
  $(list).find("li:not(:Contains(" + filter + "))").slideUp();
  $(list).find("li:Contains(" + filter + ")").slideDown();
  } else {
  $(list).find("li").slideDown();
  }
  return false;
  })
  .keyup( function () {
  $(this).change();
  });
  }

      //Slide Panel Search Email
  listFilter($("#searchMail"), $("#mail-list"));

  }(jQuery));

  //*** Refresh Content ***//
  $('.refresh-content > i').on("click", function(){
  $(this).parent().parent().parent().parent().addClass("loading-wait").delay(3000).queue(function(next){
    $(this).removeClass("loading-wait");
      next();
  });
  $(this).addClass("fa-spin").delay(3000).queue(function(next){
      $(this).removeClass("fa-spin");
      next();
  });
  });

  //*** Expand Content ***//
  $('.expand-content').on("click", function(){
    $(this).parent().parent().parent().toggleClass("expand-this");
  });

  //*** Delete Content ***//
  $('.close-content').on("click", function(){
    $(this).parent().parent().parent().slideUp();
  });
      
  // Activates Tooltips for Social Links
  $('[data-toggle="tooltip"]').tooltip(); 

  // Activates Popovers for Social Links 
  $('[data-toggle="popover"]').popover();  

  // Activates Tooltips for Social Links
  $('.tooltip-social').tooltip({
  selector: "a[data-toggle=tooltip]"
  });


  //**** New Order ****//
  $("#new-orders").sparkline([4,5,6,7,6,5,4,3,3,4], {
  type: 'bar',
  height: '40px',
  barSpacing:2,
  barWidth: 5,
  barColor: '#806fff',
  negBarColor: '#806fff'});

  //**** My Balance ****//
  $("#my-balance").sparkline([4,5,6,7,8,6,5,6,7,4], {
  type: 'bar',
  height: '40px',
  barSpacing:2,
  barWidth: 5,
  barColor: '#6d6d6d',
  negBarColor: '#6d6d6d'});

  $('#tags_1').tagsInput({width:'auto'});

  // Smart Wizard     
  $('#wizard').smartWizard();

  function onFinishCallback(){
  $('#wizard').smartWizard('showMessage','Finish Clicked');
  //alert('Finish Clicked');
  }  

  var foo = $('.gallery-box');
    foo.poptrox({
    usePopupCaption: true
  });

  var foo = $('.open-image');
    foo.poptrox({
    usePopupCaption: true
  });

  var foo = $('.timeline-gallery');
    foo.poptrox({
    usePopupCaption: true
  });


  $('.delete-cart').on('click', function(){
    $(this).parent().parent().slideUp();
  });

  $(".manual-adjust").userincr({
    buttonlabels:{'dec':'-','inc':'+'},
  }).data({'min':0,'max':20,'step':1});

  /*================== Location Map Hide/Show =====================*/
  $('.view-location').on('click', function(){
    $('.google-map').addClass('active');
  });
  $('.hide-location').on('click', function(){
    $('.google-map').removeClass('active');
  });

  ohSnap('Oh Snap! I cannot process your card...', {
    color: 'red', 
    icon: 'fa fa-flash',
    duration: '2000000000'
  });

   /*================== Price Table =====================*/
  $( ".price-table").on('click', function(){
  if ($(this).hasClass("active")) {
  $( this )
    $('.price-button > span').on('click', function(){
    $(this).parent().parent().addClass('active');
    $(this).parent().parent().removeClass('active');
  });
  }else{
  $('.price-button > span').on('click', function(){
    $(this).parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
  });
  }
  });

  $("#popoverone").popover({ trigger: "hover" });
  $("#popovertwo").popover({ trigger: "hover" });
  $("#popoverthree").popover({ trigger: "hover" });
  $("#popoverfour").popover({ trigger: "hover" });

  /*=================== Parallax ===================*/   
  $('.parallax').scrolly({bgParallax: true});

  $('#Grid').mixitup();

  //***** Slim  Scroll *****//
  $('#frnd-list').slimScroll({
    height: '505px',
    distance: '0px',
    wheelStep: 10,
    size: '2px'
  });


  $('.sortable').sortable();
  $('.handles').sortable({
       handle: 'span'
  });
       $('.connected').sortable({
       connectWith: '.connected'
  });
       $('.exclude').sortable({
       items: ':not(.disabled)'
  });

  //***** Slim  Scroll *****//
  $('#example-1').slimScroll({
      height: '350px',
      distance: '0px',
      wheelStep: 10,
      size: '2px'
  });

  //***** Thin Scroll *****//
  $('#example-2').slimScroll({
      height: '350px',
      wheelStep: 10,
      distance: '0px',
      size: '8px',
       position: 'left'
  });

  //***** Slim  Scroll left*****//
  $('#example-3').slimScroll({
      height: '350px',
      wheelStep: 10,
      distance: '0px',
       position: 'left',
      size: '2px'
  });

  //***** Thin Scroll Left *****//
  $('#example-4').slimScroll({
      height: '350px',
      wheelStep: 10,
      distance: '0px',
      size: '8px'
  });

  //***** Thin Scroll Left Change Color *****//
  $('#example-5').slimScroll({
      height: '100px',
      wheelStep: 10,
      distance: '0px',
      size: '8px',
       color: '#ff6f6f'
  });

  $('#keywords').tablesorter(); 
/*
  $.SyntaxHighlighter.init({
      'wrapLines':false,
      'theme': 'balupton'
  });*/

});

$( window ).on('load', function(){
    
  // Get Header Height //
  var stick = $('.top-bar').height();
   $('.side-menu-sec').css({
       "top": stick
  });

   // Get Header Height //
  var sticks = $('.top-bar').height();
   $('.panel-content').css({
       "margin-top": sticks
  });

});