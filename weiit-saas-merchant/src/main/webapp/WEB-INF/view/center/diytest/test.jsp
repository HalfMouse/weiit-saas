<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
			
			
			<!-- Main content -->
			<div class="content-wrapper">
				
				<!-- Content area -->
				<div class="content">
						
					<div class="panel-content">
			          <div class="main-content-area">
			               <div class="row">
			                    <div class="col-md-6">
			                         <div class="widget white">
			                              <div class="widget-title">
			                                   <h3>Sortable List</h3>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="sortable list">
			                                             <li>Item 1</li>
			                                             <li>Item 2</li>
			                                             <li>Item 3</li>
			                                             <li>Item 4</li>
			                                             <li>Item 5</li>
			                                        </ul>
			                                   </div>
			                              </div>
			                         </div>
			                    </div>
			                    <div class="col-md-6">
			                         <div class="widget white">
			                              <div class="widget-title">
			                                   <h3>Sortable Grids</h3>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="sortable grid">
			                                             <li>Item 1</li>
			                                             <li>Item 2</li>
			                                             <li>Item 3</li>
			                                             <li>Item 4</li>
			                                             <li>Item 5</li>
			                                             <li>Item 6</li>
			                                        </ul>
			                                   </div>
			                              </div>
			                         </div>
			                    </div>
			               </div>
			               <div class="row">
			                    <div class="col-md-6">
			                         <div class="widget white">
			                              <div class="widget-title">
			                                   <h3>Exclude List</h3>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="exclude list">
			                                             <li>Item 1</li>
			                                             <li>Item 2</li>
			                                             <li>Item 3</li>
			                                             <li class="disabled">Item 4</li>
			                                             <li class="disabled">Item 5</li>
			                                             <li class="disabled">Item 6</li>
			                                        </ul>
			                                   </div>
			                              </div>
			                         </div>
			                    </div>
			                    
			                    <div class="col-md-6">
			                         <div class="widget white">
			                              <div class="widget-title">
			                                   <h3>Sortable List with Handles</h3>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="handles list">
			                                             <li><span>::</span> Item 1</li>
			                                             <li><span>::</span> Item 2</li>
			                                             <li><span>::</span> Item 3</li>
			                                             <li><span>::</span> Item 4</li>
			                                             <li><span>::</span> Item 5</li>
			                                             <li><span>::</span> Item 6</li>
			                                        </ul>
			                                   </div>
			                              </div>
			                         </div>
			                    </div>
			               </div>
			               <div class="row">
			                    <div class="col-md-12">
			                         <div class="widget white">
			                              <div class="widget-title">
			                                   <h3>Connected Sortable List</h3>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="row">
			                                        <div id="connected">
			                                             <div class="col-md-6">
			                                                  <div class="sortable-style">
			                                                       <ul class="connected list">
			                                                            <li>Item 1</li>
			                                                            <li>Item 2</li>
			                                                            <li>Item 3</li>
			                                                            <li>Item 4</li>
			                                                            <li>Item 5</li>
			                                                            <li>Item 6</li>
			                                                       </ul>
			                                                  </div>
			                                             </div>
			                                             <div class="col-md-6">
			                                                  <div class="sortable-style">
			                                                       <ul class="connected list no2">
			                                                            <li class="highlight">Item 1</li>
			                                                            <li class="highlight">Item 2</li>
			                                                            <li class="highlight">Item 3</li>
			                                                            <li class="highlight">Item 4</li>
			                                                            <li class="highlight">Item 5</li>
			                                                            <li class="highlight">Item 6</li>
			                                                       </ul>
			                                                  </div>
			                                             </div>
			                                        </div>
			                                   </div>
			                              </div>
			                         </div>
			                    </div>
			               </div>
			          </div>
			     </div><!-- Panel Content -->
						

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			
						
