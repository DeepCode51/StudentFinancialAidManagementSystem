<div id="sidebar" class="sidebar                  responsive">
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
				</script>

				<div class="sidebar-shortcuts" id="sidebar-shortcuts">
					<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
						
<!-- 						<button class="btn btn-info" onclick="changeMenus('index');" title="业务菜单"> -->
<!-- 							<i class="ace-icon fa fa-pencil"></i> -->
<!-- 						</button> -->
						
<!-- 						<button class="btn btn-success" onclick="changeMenus('2');" title="系统菜单"> -->
<!-- 							<i class="ace-icon fa fa-signal"></i> -->
<!-- 						</button> -->

<!-- 						#section:basics/sidebar.layout.shortcuts -->
<!-- 						<button class="btn btn-warning" onclick="changeMenus('3');" title="菜单(类型三)"> -->
<!-- 							<i class="ace-icon fa fa-book"></i> -->
<!-- 						</button> -->

<!-- 						<button class="btn btn-danger" onclick="changeMenus('4');" title="菜单(类型四)"> -->
<!-- 							<i class="ace-icon fa fa-cogs"></i> -->
<!-- 						</button> -->

						<!-- /section:basics/sidebar.layout.shortcuts -->
					</div>

					<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>

						<span class="btn btn-info"></span>

						<span class="btn btn-warning"></span>

						<span class="btn btn-danger"></span>
					</div>
				</div><!-- /.sidebar-shortcuts -->

				<ul class="nav nav-list">
					<li class="">
						<a href="main/index">
							<i class="menu-icon fa fa-tachometer"></i>
							<span class="menu-text">后台首页</span>
						</a>
						<b class="arrow"></b>
					</li>


				<c:forEach items="${menuList}" var="menu1">
				<c:if test="${menu1.hasMenu && '1' == menu1.MENU_STATE}">
					<li class=""  id="lm${menu1.MENU_ID }">
						<a style="cursor:pointer;" class="dropdown-toggle">
							<i class="${menu1.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu1.MENU_ICON}"></i>
							<span class="menu-text">
								${menu1.MENU_NAME }
							</span>
							<c:if test="${'[]' != menu1.subMenu}"><b class="arrow fa fa-angle-down"></b></c:if>
						</a>
						<b class="arrow"></b>
						<c:if test="${'[]' != menu1.subMenu}">
						<ul class="submenu">
						<c:forEach items="${menu1.subMenu}" var="menu2">
							<c:if test="${menu2.hasMenu && '1' == menu2.MENU_STATE}">
							<li class="" id="z${menu2.MENU_ID }">
								<a style="cursor:pointer;" <c:if test="${not empty menu2.MENU_URL && '#' != menu2.MENU_URL}">target="mainFrame" onclick="siMenu('z${menu2.MENU_ID }','lm${menu1.MENU_ID }','${menu2.MENU_NAME }','${menu2.MENU_URL }')"</c:if><c:if test="${'[]' != menu2.subMenu}"> class="dropdown-toggle"</c:if>>
									<i class="${menu2.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu2.MENU_ICON}"></i>
										${menu2.MENU_NAME }
									<c:if test="${'[]' != menu2.subMenu}"><b class="arrow fa fa-angle-down"></b></c:if>
								</a>
								<b class="arrow"></b>
								<c:if test="${'[]' != menu2.subMenu}">
								<ul class="submenu">
									<c:forEach items="${menu2.subMenu}" var="menu3">
									<c:if test="${menu3.hasMenu && '1' == menu3.MENU_STATE}">
										<li class="" id="m${menu3.MENU_ID }">
											<a style="cursor:pointer;" <c:if test="${not empty menu3.MENU_URL && '#' != menu3.MENU_URL}">target="mainFrame" onclick="siMenu('m${menu3.MENU_ID }','z${menu2.MENU_ID }','${menu3.MENU_NAME }','${menu3.MENU_URL }')"</c:if><c:if test="${'[]' != menu3.subMenu}"> class="dropdown-toggle"</c:if>>
												<i class="${menu3.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu3.MENU_ICON}"></i>
													${menu3.MENU_NAME }
												<c:if test="${'[]' != menu3.subMenu}"><b class="arrow fa fa-angle-down"></b></c:if>
											</a>
											<b class="arrow"></b>
	
											<c:if test="${'[]' != menu3.subMenu}">
											<ul class="submenu">
												<c:forEach items="${menu3.subMenu}" var="menu4">
												<c:if test="${menu4.hasMenu && '1' == menu4.MENU_STATE}">
												<li class="" id="n${menu4.MENU_ID }">
													<c:if test="${'[]' != menu4.subMenu}">
													<a style="cursor:pointer;" target="mainFrame" target="mainFrame" onclick="siMenu('n${menu4.MENU_ID }','m${menu3.MENU_ID }','${menu4.MENU_NAME }','menu/otherlistMenu.do?MENU_ID=${menu4.MENU_ID }')">
													</c:if>
													<c:if test="${'[]' == menu4.subMenu}">
													<a style="cursor:pointer;" target="mainFrame" <c:if test="${not empty menu4.MENU_URL && '#' != menu4.MENU_URL}">target="mainFrame" onclick="siMenu('n${menu4.MENU_ID }','m${menu3.MENU_ID }','${menu4.MENU_NAME }','${menu4.MENU_URL }')"</c:if>>
													</c:if>
														<i class="${menu4.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu4.MENU_ICON}"></i>
														${menu4.MENU_NAME }
													</a>
													<b class="arrow"></b>
												</li>
												</c:if>
												</c:forEach>
											</ul>
											</c:if>
										</li>
										</c:if>
									</c:forEach>
								</ul>
								</c:if>
							</li>
							</c:if>
						</c:forEach>
						</ul>
						</c:if>
					</li>
				</c:if>
				</c:forEach>

				</ul><!-- /.nav-list -->

				<!-- #section:basics/sidebar.layout.minimize -->
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>

				<!-- /section:basics/sidebar.layout.minimize -->
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
				</script>
			</div>