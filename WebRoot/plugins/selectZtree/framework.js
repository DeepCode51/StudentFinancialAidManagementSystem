var parentTopHeight;
var parentBottomHeight;
var parentTopHeight_left;
var parentBottomHeight_left;
var parentTopHeight_middle;
var parentBottomHeight_middle;
var fixHeight;
var skinName;
var themeColor = "blue";
var broswerFlag;
var fontSize = 12;
var prePath = "../../";
var exitVtab = 0;
var vtabIdx = 0;
var hasIframe = 0;
var parentScrollHeight;
var boxWhiteBg = false;
var hasScrollContent = true;
var splitMode = false;
var positionTarget = "";
var box2Custom = false;
var box3Custom = false;
var box4Custom = false;
var boxIe6Flag = 0;
var boxIe7Flag = 0;
var isHeadFixMode = 0;
var headFixExcude = 0;
var headFixExcude2 = 0;
var depth = 500;
$(function () {
    closeProgress();
    _initComplete();
});

(function (a) {
    a.fn.render = function () {
        if (a(this).hasClass("spliter")) {
            try {
                a(this).spliterRender()
            } catch (b) {
                alert("分隔条出错，注意脚本的引入：spliter.js")
            }
        }
        if (a(this).is("input")) {
            if (a(this).attr("type") == "text") {
                if (a(this).hasClass("autoComplete")) {
                    if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                        a(this).textInputStyleRender()
                    }
                    try {
                        a(this).attr("trueType", "autoComplete");
                        a(this).autoCompleteRender()
                    } catch (b) {
                        alert("自动完成框出错，注意脚本的引入：autoComplete.js")
                    }
                }
                if (a(this).hasClass("autoCompleteIcon")) {
                    a(this).attr("trueType", "autoComplete");
                    a(this).textInputStyleRender()
                } else {
                    if (a(this).hasClass("color")) {
                        if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                            a(this).textInputStyleRender()
                        }
                        try {
                            a(this).attr("trueType", "color");
                            a(this).colorRender()
                        } catch (b) {
                            alert("颜色选择器出错，注意脚本的引入：color.js")
                        }
                    } else {
                        if (a(this).hasClass("date")) {
                            if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                                a(this).attr("trueType", "date");
                                a(this).dateRender()
                            }
                        } else {
                            if (a(this).hasClass("dateIcon")) {
                                a(this).attr("trueType", "date");
                                a(this).textInputStyleRender()
                            } else {
                                if (a(this).hasClass("keypad")) {
                                    if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                                        a(this).textInputStyleRender()
                                    }
                                    try {
                                        a(this).attr("trueType", "keypad");
                                        a(this).keypadRender()
                                    } catch (b) {
                                        alert("软键盘控件出错，注意脚本的引入：keypad.js")
                                    }
                                } else {
                                    if (a(this).hasClass("stepper")) {
                                        if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                                            a(this).textInputStyleRender()
                                        }
                                        try {
                                            a(this).attr("trueType", "stepper");
                                            a(this).stepperRender()
                                        } catch (b) {
                                            alert("数字步进器出错，注意脚本的引入：stepper.js")
                                        }
                                    } else {
                                        if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                                            a(this).attr("trueType", "textinput");
                                            a(this).textinputRender()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (a(this).attr("type") == "button" || a(this).attr("type") == "submit" || a(this).attr("type") == "reset") {
                    if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                        a(this).buttonInputRender()
                    }
                } else {
                    if (a(this).attr("type") == "file") {
                        if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                            a(this).attr("trueType", "file");
                            a(this).fileRender()
                        }
                    } else {
                        if (a(this).attr("type") == "password") {
                            if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                                a(this).attr("trueType", "password");
                                a(this).passInputRender()
                            }
                            if (a(this).hasClass("keypad")) {
                                if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                                    a(this).textInputStyleRender()
                                }
                                try {
                                    a(this).attr("trueType", "keypad");
                                    a(this).keypadRender()
                                } catch (b) {
                                    alert("软键盘控件出错，注意脚本的引入：keypad.js")
                                }
                            }
                        } else {
                            if (a(this).attr("type") == "radio") {
                                a(this).attr("trueType", "radio")
                            } else {
                                if (a(this).attr("type") == "checkbox") {
                                    a(this).attr("trueType", "checkbox")
                                } else {
                                    if (a(this).attr("type") == "hidden") {
                                        a(this).attr("trueType", "hidden")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if (a(this).is("button")) {
                if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                    a(this).buttonRender()
                }
            } else {
                if (a(this).is("textarea")) {
                    if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                        a(this).attr("trueType", "textarea");
                        a(this).textareaRender()
                    }
                } else {
                    if (a(this).is("select")) {
                        if (a(this).attr("keepDefaultStyle") == "true" || a(this).attr("keepDefaultStyle") == true) {} else {
                            a(this).attr("trueType", "select");
                            a(this).prev(".mainCon").attr("trueType", "q_select");
                            a(this).selectRender()
                        }
                    } else {
                        if (a(this).is("table")) {
                            if (a(this).hasClass("tableStyle")) {
                                a(this).tableRender()
                            } else {
                                if (a(this).hasClass("treeTable")) {
                                    try {
                                        a(this).treeTableRender()
                                    } catch (b) {
                                        alert("table树形表格出错，注意脚本的引入：treeTable.js")
                                    }
                                } else {
                                    if (a(this).hasClass("detailTable")) {
                                        try {
                                            a(this).addClass("tableStyle");
                                            a(this).tableRender();
                                            a(this).detailTableRender()
                                        } catch (b) {
                                            alert("table父子表格出错，注意脚本的引入：detailTable.js")
                                        }
                                    }
                                }
                            }
                        } else {
                            if (a(this).is("a")) {
                                if (a(this).hasClass("imgPreview")) {
                                    try {
                                        a(this).imagePreviewRender()
                                    } catch (b) {
                                        alert("图片预览出错，注意脚本的引入：imgPreview.js")
                                    }
                                } else {
                                    if (a(this).hasClass("imgZoom")) {
                                        try {
                                            a(this).imgZoomRender()
                                        } catch (b) {
                                            alert("图片区域放大出错，注意脚本的引入：imgZoom.js")
                                        }
                                    }
                                }
                            } else {
                                if (a(this).is("img")) {
                                    if (a(this).hasClass("imgFrame")) {
                                        try {
                                            a(this).imgFrameRender()
                                        } catch (b) {
                                            alert("图片边框渲染出错，注意脚本的引入：imgFrame.js")
                                        }
                                    } else {
                                        if (a(this).hasClass("imgFade")) {
                                            try {
                                                a(this).imgFadeRender()
                                            } catch (b) {
                                                alert("图片渐显出错，注意脚本的引入：imgFade.js")
                                            }
                                        }
                                    }
                                } else {
                                    if (a(this).is("div")) {
                                        if (a(this).hasClass("box1")) {
                                            a(this).box1Render()
                                        } else {
                                            if (a(this).hasClass("box2")) {
                                                a(this).box2Render()
                                            } else {
                                                if (a(this).hasClass("box3")) {
                                                    a(this).box3Render()
                                                } else {
                                                    if (a(this).hasClass("box4")) {
                                                        a(this).box4Render()
                                                    } else {
                                                        if (a(this).hasClass("floatPanel")) {
                                                            try {
                                                                a(this).floatPanelRender()
                                                            } catch (b) {
                                                                alert("浮动面板出错，注意脚本的引入：floatPanel.js")
                                                            }
                                                        } else {
                                                            if (a(this).hasClass("selectTree")) {
                                                                try {
                                                                    a(this).attr("trueType", "selectTree");
                                                                    a(this).selectTreeRender()
                                                                } catch (b) {
                                                                    alert("树形下拉框出错，注意脚本的引入：selectTree.js，ztree.js和ztree.css")
                                                                }
                                                            } else {
                                                                if (a(this).hasClass("filter")) {
                                                                    try {
                                                                        a(this).attr("trueType", "filter");
                                                                        a(this).filterRender()
                                                                    } catch (b) {
                                                                        alert("条件过滤器出错，注意脚本的引入：filter.js")
                                                                    }
                                                                } else {
                                                                    if (a(this).hasClass("lister")) {
                                                                        try {
                                                                            a(this).attr("trueType", "lister");
                                                                            a(this).listerRender()
                                                                        } catch (b) {
                                                                            alert("双向选择器出错，注意脚本的引入：lister.js")
                                                                        }
                                                                    } else {
                                                                        if (a(this).hasClass("listerTree")) {
                                                                            try {
                                                                                a(this).attr("trueType", "listerTree");
                                                                                a(this).listerTreeRender()
                                                                            } catch (b) {
                                                                                alert("树形双选器出错，注意脚本的引入：listerTree.js")
                                                                            }
                                                                        } else {
                                                                            if (a(this).hasClass("rating")) {
                                                                                try {
                                                                                    a(this).attr("trueType", "rating");
                                                                                    a(this).ratingRender()
                                                                                } catch (b) {
                                                                                    alert("评星级控件出错，注意脚本的引入：rating.js")
                                                                                }
                                                                            } else {
                                                                                if (a(this).hasClass("popupMenu")) {
                                                                                    a(this).popupMenuRender()
                                                                                } else {
                                                                                    if (a(this).hasClass("basicTab")) {
                                                                                        try {
                                                                                            a(this).basicTabRender()
                                                                                        } catch (b) {
                                                                                            alert("基本选项卡出错，注意脚本的引入：basicTab.js")
                                                                                        }
                                                                                    } else {
                                                                                        if (a(this).hasClass("verticalTab")) {
                                                                                            try {
                                                                                                a(this).verticalTabRender()
                                                                                            } catch (b) {
                                                                                                alert("纵向选项卡出错，注意脚本的引入：verticalTab.js")
                                                                                            }
                                                                                        } else {
                                                                                            if (a(this).hasClass("singleNav")) {
                                                                                                a(this).singleNavRender()
                                                                                            } else {
                                                                                                if (a(this).hasClass("singleNavMin")) {
                                                                                                    a(this).singleNavMinRender()
                                                                                                } else {
                                                                                                    if (a(this).hasClass("accordition")) {
                                                                                                        try {
                                                                                                            a(this).accorditionRender()
                                                                                                        } catch (b) {
                                                                                                            alert("抽屉容器出错，注意脚本的引入：accordion.js")
                                                                                                        }
                                                                                                    } else {
                                                                                                        if (a(this).hasClass("navIcon")) {
                                                                                                            a(this).hover(function () {
                                                                                                                a(this).addClass("navIcon_hover")
                                                                                                            }, function () {
                                                                                                                a(this).removeClass("navIcon_hover")
                                                                                                            })
                                                                                                        } else {
                                                                                                            if (a(this).hasClass("navIconSmall")) {
                                                                                                                a(this).hover(function () {
                                                                                                                    a(this).addClass("navIconSmall_hover")
                                                                                                                }, function () {
                                                                                                                    a(this).removeClass("navIconSmall_hover")
                                                                                                                })
                                                                                                            } else {
                                                                                                                if (a(this).hasClass("pageNumber")) {
                                                                                                                    try {
                                                                                                                        a(this).pageNumberRender()
                                                                                                                    } catch (b) {
                                                                                                                        alert("数字分页组件出错，注意脚本的引入：pageNumber.js")
                                                                                                                    }
                                                                                                                } else {
                                                                                                                    if (a(this).hasClass("pageArrow")) {
                                                                                                                        try {
                                                                                                                            a(this).pageArrowRender()
                                                                                                                        } catch (b) {
                                                                                                                            alert("箭头分页组件出错，注意脚本的引入：pageArrow.js")
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    };
    a.fn.setValue = function (c) {
        var b = a(this);
        if (b.attr("trueType") == "select") {
            b.attr("selectedValue", c);
            b.render()
        } else {
            if (b.attr("trueType") == "selectTree") {
                b.attr("selectedValue", c);
                b.render()
            } else {
                if (b.attr("trueType") == "lister") {
                    b.listerSetValue(c)
                } else {
                    if (b.attr("trueType") == "listerTree") {
                        b.listerTreeSetValue(c)
                    } else {
                        if (b.attr("trueType") == "filter") {
                            b.attr("selectedValue", c);
                            b.render()
                        }
                    }
                }
            }
        }
    };
    a.fn.resetValue = function () {
        var b = a(this);
        if (b.attr("trueType") == "select") {
            b.render()
        } else {
            if (b.attr("trueType") == "selectTree") {
                b.render()
            } else {
                if (b.attr("trueType") == "lister") {
                    b.render()
                } else {
                    if (b.attr("trueType") == "listerTree") {
                        b.render()
                    } else {
                        if (b.attr("trueType") == "filter") {
                            b.render()
                        }
                    }
                }
            }
        }
    };
    a.fn.addItem = function (c) {
        var b = a(this);
        if (b.attr("trueType") == "select") {
            b.selectAddItem(c)
        } else {
            if (b.attr("trueType") == "selectTree") {
                b.selectTreeAddItem(c)
            } else {
                if (b.attr("trueType") == "lister") {
                    b.listerAddItem(c)
                } else {
                    if (b.attr("trueType") == "listerTree") {
                        b.listerTreeAddItem(c)
                    }
                }
            }
        }
    };
    a.fn.removeItem = function (c) {
        var b = a(this);
        if (b.attr("trueType") == "select") {
            b.selectRemoveItem(c)
        } else {
            if (b.attr("trueType") == "selectTree") {
                b.selectTreeRemoveItem(c)
            } else {
                if (b.attr("trueType") == "lister") {
                    b.listerRemoveItem(c)
                } else {
                    if (b.attr("trueType") == "listerTree") {
                        b.listerTreeRemoveItem(c)
                    }
                }
            }
        }
    };
    a.fn.selectValue = function (c) {
        var b = a(this);
        if (b.attr("trueType") == "lister") {
            b.listerSelectValue(c)
        } else {
            if (b.attr("trueType") == "listerTree") {
                b.listerTreeSelectValue(c)
            }
        }
    };
    a.fn.unSelectValue = function (c) {
        var b = a(this);
        if (b.attr("trueType") == "lister") {
            b.listerUnSelectValue(c)
        } else {
            if (b.attr("trueType") == "listerTree") {
                b.listerTreeUnSelectValue(c)
            }
        }
    };
    a.fn.box1Render = function () {
        var b;
        if (a(this).find(".boxContent").length > 0) {} else {
            b = a(this).html();
            a(this).empty();
            if (a(this).attr("whiteBg") == "true" || a(this).attr("whiteBg") == true || hasScrollContent == false || boxWhiteBg == true) {
                a("<div class='box1_topcenter2'><div class='box1_topleft2'><div class='box1_topright2'></div></div></div>").appendTo(a(this));
                a("<div class='box1_middlecenter'><div class='box1_middleleft2'><div class='box1_middleright2'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box1_bottomcenter2'><div class='box1_bottomleft2'><div class='box1_bottomright2'></div></div></div>").appendTo(a(this))
            } else {
                a("<div class='box1_topcenter'><div class='box1_topleft'><div class='box1_topright'></div></div></div>").appendTo(a(this));
                a("<div class='box1_middlecenter'><div class='box1_middleleft'><div class='box1_middleright'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box1_bottomcenter'><div class='box1_bottomleft'><div class='box1_bottomright'></div></div></div>").appendTo(a(this))
            }
            a(this).find(".boxContent").html(b)
        }
        a(this).box1Build()
    };
    a.fn.box1Build = function () {
        if (a(this).attr("panelWidth") != null) {
            var d = a(this).attr("panelWidth");
            var c = d.substr(d.length - 1, 1);
            if (c == "%") {
                a(this).width(d)
            } else {
                var e = Number(a(this).attr("panelWidth"));
                a(this).width(e)
            }
        }
        if (a(this).attr("panelHeight") != null) {
            var b;
            if (a(this).attr("whiteBg") == "true" || a(this).attr("whiteBg") == true) {
                a(this).find(".box1_topcenter2").height(20);
                a(this).find(".box1_bottomcenter2").height(22);
                b = Number(a(this).attr("panelHeight")) - a(this).find(".box1_topcenter2").outerHeight() - a(this).find(".box1_bottomcenter2").outerHeight()
            } else {
                a(this).find(".box1_topcenter").height(20);
                a(this).find(".box1_bottomcenter").height(22);
                b = Number(a(this).attr("panelHeight")) - a(this).find(".box1_topcenter").outerHeight() - a(this).find(".box1_bottomcenter").outerHeight()
            }
            a(this).find(".boxContent").height(b)
        }
        if (a(this).attr("overflow") == "true" || a(this).attr("overflow") == true) {
            a(this).find(".boxContent").css({
                overflow: "auto"
            })
        } else {
            if (a(this).attr("overflow") == "false" || a(this).attr("overflow") == false) {
                a(this).find(".boxContent").css({
                    overflow: "hidden"
                })
            } else {
                a(this).find(".boxContent").css({
                    overflow: "visible"
                })
            }
        }
        if (a(this).attr("position") == "center") {
            a(this).addClass("center")
        } else {
            a(this).removeClass("center")
        }
    };
    a.fn.box2Render = function () {
        var b;
        if (a(this).find(".boxContent").length > 0) {} else {
            b = a(this).html();
            a(this).empty();
            if (box2Custom) {
                a("<div class='box2_topcenter2' id='box2_topcenter'><div class='box2_topleft2'><div class='box2_topright2'><div class='title'></div><div class='status'><span class='ss'><a></a></span></div><div class='clear'></div></div></div></div>").appendTo(a(this));
                a("<div class='box2_middlecenter2'><div class='box2_middleleft2'><div class='box2_middleright2'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box2_bottomcenter2' id='box2_bottomcenter'><div class='box2_bottomleft2'><div class='box2_bottomright2'></div></div></div>").appendTo(a(this))
            } else {
                a("<div class='box2_topcenter' id='box2_topcenter'><div class='box2_topleft'><div class='box2_topright'><div class='title'></div><div class='status'><span class='ss'><a></a></span></div><div class='clear'></div></div></div></div>").appendTo(a(this));
                a("<div class='box2_middlecenter'><div class='box2_middleleft'><div class='box2_middleright'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box2_bottomcenter' id='box2_bottomcenter'><div class='box2_bottomleft'><div class='box2_bottomright'></div></div></div>").appendTo(a(this))
            }
            a(this).find(".boxContent").html(b)
        }
        a(this).box2Build()
    };
    a.fn.box2Build = function () {
        var f = a(this);
        if (a(this).attr("panelTitle") != null) {
            a(this).find(".title").text(a(this).attr("panelTitle"))
        }
        if (a(this).attr("panelWidth") != null) {
            var c = a(this).attr("panelWidth");
            var l = c.substr(c.length - 1, 1);
            if (l == "%") {
                a(this).width(c)
            } else {
                var b = Number(a(this).attr("panelWidth"));
                a(this).width(b)
            }
        }
        if (a(this).attr("panelHeight") != null) {
            var m = Number(a(this).attr("panelHeight")) - a(this).find("#box2_topcenter").outerHeight() - a(this).find("#box2_bottomcenter").outerHeight();
            a(this).find(".boxContent").height(m)
        }
        if (a(this).attr("overflow") == "true" || a(this).attr("overflow") == true) {
            a(this).find(".boxContent").css({
                overflow: "auto"
            })
        } else {
            if (a(this).attr("overflow") == "false" || a(this).attr("overflow") == false) {
                a(this).find(".boxContent").css({
                    overflow: "hidden"
                })
            } else {
                a(this).find(".boxContent").css({
                    overflow: "visible"
                })
            }
        }
        var e = "true";
        if (a(this).attr("showStatus") != null) {
            e = a(this).attr("showStatus")
        }
        var i = "javascript:;";
        if (a(this).attr("panelUrl") != null) {
            i = a(this).attr("panelUrl")
        }
        var h = "_self";
        if (a(this).attr("panelTarget") != null) {
            h = a(this).attr("panelTarget")
        }
        var d = "收缩";
        if (a(this).attr("statusText") != null) {
            d = a(this).attr("statusText")
        }
        a(this).find(".ss").unbind("click");
        var n;
        if (d == "收缩" && e == "true") {
            a(this).find(".ss").text(d);
            a(this).find(".ss").toggle(function () {
                var o = a(this).parents(".box2").find(".boxContent");
                n = o.height();
                if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                    o.fadeOut(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "hide")
                    })
                } else {
                    o.hide(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "hide")
                    })
                }
                a(this).text("展开")
            }, function () {
                var o = a(this).parents(".box2").find(".boxContent");
                o.height(n);
                if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                    o.fadeIn(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "show")
                    })
                } else {
                    o.show(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "show")
                    })
                }
                if (a(this).parents(".box2").attr("panelHeight") == null) {
                    setTimeout(function () {
                        o.css({
                            height: "auto"
                        })
                    }, 500)
                }
                a(this).text("收缩")
            })
        } else {
            if (d == "展开" && e == "true") {
                a(this).find(".ss").text(d);
                var g = a(this).find(".boxContent");
                n = g.height();
                g.hide();
                a(this).find(".ss").toggle(function () {
                    var o = a(this).parents(".box2").find(".boxContent");
                    o.height(n);
                    if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                        o.fadeIn(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "show")
                        })
                    } else {
                        o.show(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "show")
                        })
                    }
                    if (a(this).parents(".box2").attr("panelHeight") == null) {
                        setTimeout(function () {
                            o.css({
                                height: "auto"
                            })
                        }, 500)
                    }
                    a(this).text("收缩")
                }, function () {
                    if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                        g.fadeOut(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "hide")
                        })
                    } else {
                        g.hide(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "hide")
                        })
                    }
                    a(this).text("展开")
                })
            } else {
                if (e == "true" || a(this).attr("statusText") != null) {
                    a(this).find(".ss").find("a").attr("href", i);
                    a(this).find(".ss").find("a").attr("target", h);
                    a(this).find(".ss").find("a").text(d)
                } else {
                    a(this).find(".ss").hide()
                }
            }
        }
    };
    a.fn.box3Render = function () {
        var b;
        if (a(this).find(".boxContent").length > 0) {} else {
            b = a(this).html();
            a(this).empty();
            if (box3Custom) {
                a("<div class='box3_topcenter2' id='box3_topcenter'><div class='box3_topleft2'><div class='box3_topright2'><div class='title'></div><div class='status'><span class='ss'><a></a></span></div><div class='clear'></div></div></div></div>").appendTo(a(this));
                a("<div class='box3_middlecenter2'><div class='box3_middleleft2'><div class='box3_middleright2'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box3_bottomcenter2' id='box3_bottomcenter'><div class='box3_bottomleft2'><div class='box3_bottomright2'></div></div></div>").appendTo(a(this))
            } else {
                a("<div class='box3_topcenter' id='box3_topcenter'><div class='box3_topleft'><div class='box3_topright'><div class='title'></div><div class='status'><span class='ss'><a></a></span></div><div class='clear'></div></div></div></div>").appendTo(a(this));
                a("<div class='box3_middlecenter'><div class='box3_middleleft'><div class='box3_middleright'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box3_bottomcenter' id='box3_bottomcenter'><div class='box3_bottomleft'><div class='box3_bottomright'></div></div></div>").appendTo(a(this))
            }
            a(this).find(".boxContent").html(b)
        }
        a(this).box3Build()
    };
    a.fn.box3Build = function () {
        var f = a(this);
        if (a(this).attr("panelTitle") != null) {
            a(this).find(".title").text(a(this).attr("panelTitle"))
        }
        if (a(this).attr("panelWidth") != null) {
            var c = a(this).attr("panelWidth");
            var l = c.substr(c.length - 1, 1);
            if (l == "%") {
                a(this).width(c)
            } else {
                var b = Number(a(this).attr("panelWidth"));
                a(this).width(b)
            }
        }
        if (a(this).attr("panelHeight") != null) {
            a(this).find("#box3_topcenter").height(29);
            a(this).find("#box3_bottomcenter").height(2);
            var m = Number(a(this).attr("panelHeight")) - a(this).find("#box3_topcenter").outerHeight() - a(this).find("#box3_bottomcenter").outerHeight();
            a(this).find(".boxContent").height(m)
        }
        if (a(this).attr("overflow") == "true" || a(this).attr("overflow") == true) {
            a(this).find(".boxContent").css({
                overflow: "auto"
            })
        } else {
            if (a(this).attr("overflow") == "false" || a(this).attr("overflow") == false) {
                a(this).find(".boxContent").css({
                    overflow: "hidden"
                })
            } else {
                a(this).find(".boxContent").css({
                    overflow: "visible"
                })
            }
        }
        var e = "false";
        if (a(this).attr("showStatus") != null) {
            e = a(this).attr("showStatus")
        }
        var i = "javscript:;";
        if (a(this).attr("panelUrl") != null) {
            i = a(this).attr("panelUrl")
        }
        var h = "_self";
        if (a(this).attr("panelTarget") != null) {
            h = a(this).attr("panelTarget")
        }
        var d = "更多>>";
        if (a(this).attr("statusText") != null) {
            d = a(this).attr("statusText")
        }
        a(this).find(".ss").unbind("click");
        var n;
        if (d == "收缩") {
            a(this).find(".ss").text(d);
            a(this).find(".ss").toggle(function () {
                var o = a(this).parents(".box3").find(".boxContent");
                n = o.height();
                if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                    o.fadeOut(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "hide")
                    })
                } else {
                    o.hide(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "hide")
                    })
                }
                if (a(this).parents(".box3").attr("panelHeight") == null) {
                    setTimeout(function () {
                        o.css({
                            height: "auto"
                        })
                    }, 500)
                }
                a(this).text("展开")
            }, function () {
                var o = a(this).parents(".box3").find(".boxContent");
                o.height(n);
                if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                    o.fadeIn(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "show")
                    })
                } else {
                    o.show(300, function () {
                        resetHeight();
                        f.trigger("stateChange", "show")
                    })
                }
                a(this).text("收缩")
            })
        } else {
            if (d == "展开") {
                a(this).find(".ss").text(d);
                var g = a(this).find(".boxContent");
                n = g.height();
                g.hide();
                a(this).find(".ss").toggle(function () {
                    var o = a(this).parents(".box3").find(".boxContent");
                    o.height(n);
                    if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                        o.fadeIn(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "show")
                        })
                    } else {
                        o.show(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "show")
                        })
                    }
                    if (a(this).parents(".box3").attr("panelHeight") == null) {
                        setTimeout(function () {
                            o.css({
                                height: "auto"
                            })
                        }, 500)
                    }
                    a(this).text("收缩")
                }, function () {
                    if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                        g.fadeOut(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "hide")
                        })
                    } else {
                        g.hide(300, function () {
                            resetHeight();
                            f.trigger("stateChange", "hide")
                        })
                    }
                    a(this).text("展开")
                })
            } else {
                if (e == "true" || a(this).attr("statusText") != null) {
                    a(this).find(".ss").find("a").attr("href", i);
                    a(this).find(".ss").find("a").attr("target", h);
                    a(this).find(".ss").find("a").text(d)
                } else {
                    a(this).find(".ss").hide()
                }
            }
        }
    };
    a.fn.box4Render = function () {
        var b;
        if (a(this).find(".boxContent").length > 0) {} else {
            b = a(this).html();
            a(this).empty();
            if (box4Custom) {
                a("<div class='box4_topcenter_notitle2' id='box4_notitle'><div class='box4_topleft_notitle2'><div class='box4_topright_notitle2'></div></div></div>").appendTo(a(this));
                a("<div class='box4_topcenter2' id='box4_hastitle'><div class='box4_topleft2'><div class='box4_topright2'><div class='title'></div></div></div></div>").appendTo(a(this));
                a("<div class='box4_middlecenter2'><div class='box4_middleleft2'><div class='box4_middleright2'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box4_bottomcenter2' id='box4_bottomcenter'><div class='box4_bottomleft2'><div class='box4_bottomright2'></div></div></div>").appendTo(a(this))
            } else {
                a("<div class='box4_topcenter_notitle' id='box4_notitle'><div class='box4_topleft_notitle'><div class='box4_topright_notitle'></div></div></div>").appendTo(a(this));
                a("<div class='box4_topcenter' id='box4_hastitle'><div class='box4_topleft'><div class='box4_topright'><div class='title'></div></div></div></div>").appendTo(a(this));
                a("<div class='box4_middlecenter'><div class='box4_middleleft'><div class='box4_middleright'><div class='boxContent'></div></div></div></div>").appendTo(a(this));
                a("<div class='box4_bottomcenter' id='box4_bottomcenter'><div class='box4_bottomleft'><div class='box4_bottomright'></div></div></div>").appendTo(a(this))
            }
            a(this).find(".boxContent").html(b)
        }
        a(this).box4Build()
    };
    a.fn.box4Build = function () {
        if (a(this).attr("panelTitle") != null) {
            a(this).find(".title").text(a(this).attr("panelTitle"))
        }
        var f = a(this).find("#box4_notitle");
        var b = a(this).find("#box4_hastitle");
        f.hide();
        b.hide();
        if (a(this).attr("noTitle") == "true" || a(this).attr("noTitle") == true) {
            f.show()
        } else {
            b.show()
        }
        if (a(this).attr("panelWidth") != null) {
            var g = a(this).attr("panelWidth");
            var d = g.substr(g.length - 1, 1);
            if (d == "%") {
                a(this).width(g)
            } else {
                var h = Number(a(this).attr("panelWidth"));
                a(this).width(h)
            }
        }
        if (a(this).attr("panelHeight") != null) {
            a(this).find(".box4_topcenter").height(27);
            a(this).find(".box4_bottomcenter").height(5);
            var c;
            if (a(this).attr("noTitle") == "true" || a(this).attr("noTitle") == true) {
                c = Number(a(this).attr("panelHeight")) - a(this).find("#box4_notitle").outerHeight() - a(this).find("#box4_bottomcenter").outerHeight()
            } else {
                c = Number(a(this).attr("panelHeight")) - a(this).find("#box4_hastitle").outerHeight() - a(this).find("#box4_bottomcenter").outerHeight()
            }
            a(this).find(".boxContent").height(c)
        }
        if (a(this).attr("overflow") == "true" || a(this).attr("overflow") == true) {
            a(this).find(".boxContent").css({
                overflow: "auto"
            })
        } else {
            if (a(this).attr("overflow") == "false" || a(this).attr("overflow") == false) {
                a(this).find(".boxContent").css({
                    overflow: "hidden"
                })
            } else {
                a(this).find(".boxContent").css({
                    overflow: "visible"
                })
            }
        }
        var e = a(this);
        e.find("li a").unbind("click");
        e.find("li a").each(function (l) {
            a(this).click(function () {
                e.find("li a").removeClass("current");
                a(this).addClass("current")
            })
        })
    };
    a.fn.textinputRender = function () {
        if (a(this).attr("inputMode")) {
            var e = a(this).attr("inputMode");
            if (e == "numberOnly") {
                var d = a(this)[0];
                var c = function () {
                    d.value = d.value.replace(/\D/g, "");
                    if (!validateInput(d.value, "^(0|[1-9][0-9]*)$")) {
                        d.value = d.value.substring(1)
                    }
                };
                a(this)[0].onkeyup = function () {
                    c()
                };
                a(this)[0].onafterpaste = function () {
                    c()
                }
            }
        }
        if (a(this).attr("class") == "keypad") {
            return
        }
        a(this).addClass("textinput");
        var b = null;
        a(this).hover(function () {
            if (b != a(this)[0]) {
                a(this).removeClass("textinput");
                a(this).addClass("textinput_hover")
            }
        }, function () {
            if (b != a(this)[0]) {
                a(this).removeClass("textinput_hover");
                a(this).addClass("textinput")
            }
        });
        a(this).focus(function () {
            b = a(this)[0];
            a(this).removeClass("textinput");
            a(this).removeClass("textinput_hover");
            a(this).addClass("textinput_click")
        });
        a(this).blur(function () {
            b = null;
            a(this).removeClass("textinput_click");
            a(this).addClass("textinput")
        });
        if (a(this).attr("clearable") == "true") {
            a(this).clearableTextField()
        }
        if (a(this).attr("maxNum") != null) {
            a(this).maxlength({
                maxCharacters: parseInt(a(this).attr("maxNum"))
            })
        }
        if (a(this).attr("watermark") != null) {
            a(this).watermark("watermark", a(this).attr("watermark"))
        }
    };
    a.fn.textInputStyleRender = function () {
        var b = null;
        if (a(this).attr("inputMode")) {
            var c = a(this).attr("inputMode");
            if (c == "numberOnly") {
                a(this)[0].onkeyup = function () {
                    a(this)[0].value = a(this)[0].value.replace(/\D/g, "")
                };
                a(this)[0].onafterpaste = function () {
                    a(this)[0].value = a(this)[0].value.replace(/\D/g, "")
                }
            }
        }
        a(this).hover(function () {
            if (b != a(this)[0]) {
                a(this).addClass("date_hover")
            }
        }, function () {
            if (b != a(this)[0]) {
                a(this).removeClass("date_hover")
            }
        });
        a(this).focus(function () {
            b = a(this)[0];
            a(this).removeClass("date_hover");
            a(this).addClass("date_click")
        });
        a(this).blur(function () {
            b = null;
            a(this).removeClass("date_click")
        })
    };
    a.fn.passInputRender = function () {
        var b = null;
        a(this).addClass("textinput");
        if (a(this).attr("inputMode")) {
            var c = a(this).attr("inputMode");
            if (c == "numberOnly") {
                a(this)[0].onkeyup = function () {
                    a(this)[0].value = a(this)[0].value.replace(/\D/g, "")
                };
                a(this)[0].onafterpaste = function () {
                    a(this)[0].value = a(this)[0].value.replace(/\D/g, "")
                }
            }
        }
        a(this).hover(function () {
            if (b != a(this)[0]) {
                a(this).removeClass("textinput");
                a(this).addClass("textinput_hover")
            }
        }, function () {
            if (b != a(this)[0]) {
                a(this).removeClass("textinput_hover");
                a(this).addClass("textinput")
            }
        });
        a(this).focus(function () {
            b = a(this)[0];
            a(this).removeClass("textinput");
            a(this).removeClass("textinput_hover");
            a(this).addClass("textinput_click")
        });
        a(this).blur(function () {
            b = null;
            a(this).removeClass("textinput_click");
            a(this).addClass("textinput")
        });
        if (a(this).attr("clearable") == "true") {
            a(this).clearableTextField()
        }
        if (a(this).attr("maxNum") != null) {
            a(this).maxlength({
                maxCharacters: parseInt(a(this).attr("maxNum"))
            })
        }
        if (a(this).attr("checkStrength") == "true") {
            a(this).password_strength()
        }
        a(this).caps(function (d) {
            if (jQuery.browser.safari) {
                return
            }
            if (d) {
                a.cursorMessage("注意：大写键开启了")
            } else {}
        })
    };
    a.fn.textareaRender = function () {
        var b = null;
        a(this).addClass("textarea");
        if (a(this).attr("maxNum") != null) {
            a(this).maxlength({
                maxCharacters: parseInt(a(this).attr("maxNum"))
            })
        }
        if (a(this).attr("resize") == "true") {
            a(this).TextAreaResizer()
        }
        if (a(this).attr("autoHeight") == "true") {
            a(this).css({
                height: "auto"
            });
            a(this).attr("rows", 5);
            a(this).autoGrow()
        }
        if (a(this).attr("watermark") != null) {
            a(this).watermark("watermark", a(this).attr("watermark"))
        }
        a(this).hover(function () {
            if (b != a(this)[0]) {
                a(this).removeClass("textarea");
                a(this).addClass("textarea_hover")
            }
        }, function () {
            if (b != a(this)[0]) {
                a(this).removeClass("textarea_hover");
                a(this).addClass("textarea")
            }
        });
        a(this).focus(function () {
            b = a(this)[0];
            a(this).removeClass("textarea");
            a(this).removeClass("textarea_hover");
            a(this).addClass("textarea_click")
        });
        a(this).blur(function () {
            b = null;
            a(this).removeClass("textarea_click");
            a(this).addClass("textarea")
        })
    };
    a.fn.buttonInputRender = function () {
        a(this).addClass("button");
        var b = _getStrLength(a(this).val());
        if (b < 5) {
            a(this).width(60)
        }
        a(this).hover(function () {
            a(this).removeClass("button");
            a(this).addClass("button_hover")
        }, function () {
            a(this).removeClass("button_hover");
            a(this).addClass("button")
        });
        a(this).focus(function () {
            a(this).removeClass("button");
            a(this).addClass("button_hover")
        });
        a(this).blur(function () {
            a(this).removeClass("button_hover");
            a(this).addClass("button")
        })
    };
    a.fn.buttonRender = function () {
        a(this).addClass("button");
        var c = _getStrLength(a(this).text());
        var b = 0;
        var d = 50;
        b = _getStrLength(a(this).filter(":has(span)").find("span").text());
        if (b != 0) {
            d = 20 + 7 * b + 10
        }
        if (broswerFlag == "Firefox" || broswerFlag == "Opera" || broswerFlag == "Safari") {
            a(this).filter(":has(span)").css({
                paddingLeft: "5px",
                width: d + 8 + "px"
            })
        } else {
            a(this).filter(":has(span)").css({
                paddingLeft: "5px",
                width: d + "px"
            })
        }
        if (c < 5) {
            a(this).width(66)
        }
        a(this).filter(":has(span)").find("span").css({
            cursor: "default"
        });
        a(this).hover(function () {
            a(this).removeClass("button");
            a(this).addClass("button_hover")
        }, function () {
            a(this).removeClass("button_hover");
            a(this).addClass("button")
        });
        a(this).focus(function () {
            a(this).removeClass("button");
            a(this).addClass("button_hover")
        });
        a(this).blur(function () {
            a(this).removeClass("button_hover");
            a(this).addClass("button")
        })
    };
    a.fn.dateRender = function () {
        var d = null;
        var c = "yyyy-MM-dd";
        if (a(this).attr("dateFmt") != null) {
            c = a(this).attr("dateFmt")
        }
        var b = false;
        if (a(this).attr("doubleCal") == true || a(this).attr("doubleCal") == "true") {
            b = true
        }
        a(this).hover(function () {
            if (d != a(this)[0]) {
                a(this).addClass("date_hover")
            }
        }, function () {
            if (d != a(this)[0]) {
                a(this).removeClass("date_hover")
            }
        });
        a(this).focus(function () {
            try {
                WdatePicker({
                    skin: themeColor,
                    isShowClear: true,
                    dateFmt: c,
                    doubleCalendar: b,
                    onpicked: function (e) {
                        a(this).blur()
                    }
                })
            } catch (f) {
                alert("日期选择框出错，注意脚本的引入：WdatePicker.js")
            }
            d = a(this)[0];
            a(this).removeClass("date_hover");
            a(this).addClass("date_click")
        });
        a(this).blur(function () {
            d = null;
            a(this).removeClass("date_click")
        })
    };
    a.fn.popupMenuRender = function () {
        a(this).hover(function () {
            a(this).find(".popupMenu_con").show()
        }, function () {
            a(this).find(".popupMenu_con").hide()
        })
    };
    a.fn.singleNavRender = function () {
        var b = a(this);
        b.find(">div span").each(function () {
            a(this).click(function () {
                b.find(">div").removeClass("current");
                a(this).parent("div").addClass("current")
            });
            a(this).hover(function () {
                a(this).animate({
                    paddingLeft: "40px"
                }, "fast")
            }, function () {
                a(this).animate({
                    paddingLeft: "20px"
                })
            })
        })
    };
    a.fn.singleNavMinRender = function () {
        var b = a(this);
        b.find(">div span").each(function () {
            a(this).click(function () {
                b.find(">div").removeClass("current");
                a(this).parent("div").addClass("current")
            });
            a(this).hover(function () {
                a(this).animate({
                    paddingLeft: "30px"
                }, "fast")
            }, function () {
                a(this).animate({
                    paddingLeft: "10px"
                })
            })
        })
    };
    a.fn.tableRender = function () {
        return this.each(function () {
            if (a(this).attr("thTrueWidth") == "true" || a(this).attr("thTrueWidth") == true) {
                a("#scrollContent").css({
                    overflowX: "auto"
                });
                var b = 0;
                a(this).find("tr").eq(0).find("th").each(function () {
                    var e = Number(a(this).attr("trueWidth"));
                    b = b + e;
                    a(this).width(e)
                });
                a(this).width(b)
            } else {
                if (a(this).attr("tdTrueWidth") == "true" || a(this).attr("tdTrueWidth") == true) {
                    a("#scrollContent").css({
                        overflowX: "auto"
                    });
                    var g = 0;
                    a(this).find("tr").eq(0).find("td").each(function () {
                        var e = Number(a(this).attr("trueWidth"));
                        g = g + e;
                        a(this).width(e)
                    });
                    a(this).width(g)
                }
            }
            a(this).find("th").addClass("th");
            if (a(this).find("tr").eq(1).find("td").eq(0).find('input[type="checkbox"]').length == 1) {
                if (a(this).attr("useCheckBox") != "false") {
                    a(this).attr("useCheckBox", "true")
                }
                if (a(this).attr("useMultColor") != "false") {
                    a(this).attr("useMultColor", "true")
                }
            }
            if (a(this).find("tr").eq(1).find("td").eq(0).find('input[type="radio"]').length == 1) {
                if (a(this).attr("useRadio") != "false") {
                    a(this).attr("useRadio", "true")
                }
            }
            if (a(this).attr("formMode") == "line") {
                a(this).attr("useColor", "false");
                a(this).attr("useHover", "false");
                a(this).attr("useClick", "false");
                a(this).find("th").css({
                    fontWeight: "bold",
                    "text-align": "center"
                });
                a(this).find("tr").find("td:even").css("text-align", "right");
                if (a(this).attr("footer") != null) {
                    if (a(this).attr("footer") == "left") {
                        a(this).find("tr:last").find("td").css("text-align", "left")
                    } else {
                        if (a(this).attr("footer") == "right") {
                            a(this).find("tr:last").find("td").css("text-align", "right")
                        } else {
                            if (a(this).attr("footer") == "center") {
                                a(this).find("tr:last").find("td").css("text-align", "center")
                            } else {
                                if (a(this).attr("footer") == "normal") {
                                    a(this).find("tr:last").find("td:even").css("text-align", "right")
                                }
                            }
                        }
                    }
                } else {
                    var h = a(this).find("tr:last").find("td").eq(0).attr("colspan");
                    if (h) {
                        if (h.toString() != "1") {
                            a(this).find("tr:last").find("td").css("text-align", "center")
                        }
                    }
                }
                a(this).find("td").css({
                    paddingTop: "3px",
                    paddingBottom: "3px"
                })
            } else {
                if (a(this).attr("formMode") == "transparent") {
                    a(this).attr("useColor", "false");
                    a(this).attr("useHover", "false");
                    a(this).attr("useClick", "false");
                    a(this).find("th").css({
                        fontWeight: "bold",
                        "text-align": "center"
                    });
                    a(this).css({
                        border: "none",
                        backgroundColor: "transparent"
                    });
                    a(this).find("tr").css({
                        border: "none",
                        backgroundColor: "transparent"
                    });
                    a(this).find("tr").find("td:even").css("text-align", "right");
                    if (a(this).attr("footer") != null) {
                        if (a(this).attr("footer") == "left") {
                            a(this).find("tr:last").find("td").css("text-align", "left")
                        } else {
                            if (a(this).attr("footer") == "right") {
                                a(this).find("tr:last").find("td").css("text-align", "right")
                            } else {
                                if (a(this).attr("footer") == "center") {
                                    a(this).find("tr:last").find("td").css("text-align", "center")
                                } else {
                                    if (a(this).attr("footer") == "normal") {
                                        a(this).find("tr:last").find("td:even").css("text-align", "right")
                                    }
                                }
                            }
                        }
                    } else {
                        var f = a(this).find("tr:last").find("td").eq(0).attr("colspan");
                        if (f) {
                            if (f.toString() != "1") {
                                a(this).find("tr:last").find("td").css("text-align", "center")
                            }
                        }
                    }
                    a(this).find("td").css({
                        paddingTop: "3px",
                        paddingBottom: "3px",
                        border: "none"
                    })
                } else {
                    if (a(this).attr("formMode") == "view") {
                        a(this).attr("useColor", "false");
                        a(this).attr("useHover", "false");
                        a(this).attr("useClick", "false");
                        a(this).find("th").css({
                            fontWeight: "bold",
                            "text-align": "center"
                        });
                        a(this).find("tr").find("td:even").css({
                            textAlign: "right",
                            backgroundColor: "#eeeeee"
                        });
                        if (a(this).attr("footer") != null) {
                            if (a(this).attr("footer") == "left") {
                                a(this).find("tr:last").find("td").css({
                                    textAlign: "left",
                                    backgroundColor: "#ffffff"
                                })
                            } else {
                                if (a(this).attr("footer") == "right") {
                                    a(this).find("tr:last").find("td").css({
                                        textAlign: "right",
                                        backgroundColor: "#ffffff"
                                    })
                                } else {
                                    if (a(this).attr("footer") == "center") {
                                        a(this).find("tr:last").find("td").css({
                                            textAlign: "center",
                                            backgroundColor: "#ffffff"
                                        })
                                    } else {
                                        if (a(this).attr("footer") == "normal") {
                                            a(this).find("tr:last").find("td:even").css({
                                                textAlign: "right",
                                                backgroundColor: "#ffffff"
                                            })
                                        }
                                    }
                                }
                            }
                        } else {
                            var h = a(this).find("tr:last").find("td").eq(0).attr("colspan");
                            if (h) {
                                if (h.toString() != "1") {
                                    a(this).find("tr:last").find("td").css({
                                        textAlign: "center",
                                        backgroundColor: "#ffffff"
                                    })
                                }
                            }
                        }
                        a(this).find("td").css({
                            paddingTop: "6px",
                            paddingBottom: "6px"
                        })
                    }
                }
            }
            if (a(this).attr("useColor") != "false") {
                a(this).find("tr:even").addClass("odd")
            }
            if (a(this).attr("useHover") != "false") {
                a(this).find("tr").hover(function () {
                    a(this).addClass("highlight")
                }, function () {
                    a(this).removeClass("highlight")
                })
            }
            if (a(this).attr("sortMode") == "true") {
                a(this).find("th").filter(":has(span)").hover(function () {
                    a(this).removeClass("th");
                    a(this).addClass("th_over")
                }, function () {
                    a(this).removeClass("th_over");
                    a(this).addClass("th")
                });
                a(this).find("th span").addClass("sort_off");
                a(this).find("th").click(function () {})
            }
            if (a(this).attr("useClick") != "false") {
                a(this).attr("useClick", "true")
            }
            if (a(this).attr("useClick") == "true" && a(this).attr("useMultColor") == "true") {
                a(this).attr("useClick", "false")
            }
            if (a(this).attr("useRadio") != "true") {
                a(this).attr("useRadio", "false")
            }
            if (a(this).attr("useCheckBox") != "true") {
                a(this).attr("useCheckBox", "false")
            }
            if (a(this).attr("useClick") != "false") {
                if (a(this).attr("useRadio") == "false") {
                    a(this).find("tr").click(function () {
                        a(this).siblings().removeClass("selected");
                        a(this).addClass("selected")
                    })
                } else {
                    a(this).find('input[type="radio"]:checked').parents("tr").addClass("selected");
                    a(this).find("tr").click(function () {
                        a(this).siblings().removeClass("selected");
                        a(this).addClass("selected");
                        a(this).find('input[type="radio"]').attr("checked", "checked")
                    })
                }
            }
            if (a(this).attr("useMultColor") == "true") {
                if (a(this).attr("useCheckBox") == "false") {
                    a(this).find("tr").click(function () {
                        a(this).toggleClass("selected")
                    })
                } else {
                    a(this).find('input[type="checkbox"]:checked').parents("tr").addClass("selected");
                    if (a(this).find("th").length > 0) {
                        var c = a("<img src=" + prePath + 'libs/icons/checkAllOff.gif title="点击全选" class="hand"></span>');
                        a(this).find("th").eq(0).addClass("ali02").html("").append(c);
                        try {
                            enableTooltips()
                        } catch (d) {}
                        if (a(this).attr("headFixMode") == "true") {
                            c.toggle(function () {
                                a("table:[class=tableStyle]").find("tr").each(function () {
                                    a(this).addClass("selected");
                                    a(this).find('input[type="checkbox"]').attr("checked", "checked")
                                });
                                a(this).attr("src", prePath + "libs/icons/checkAllOn.gif");
                                a(this).attr("title", "取消全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (i) {}
                            }, function () {
                                a("table:[class=tableStyle]").find("tr").each(function () {
                                    if (a(this).hasClass("selected")) {
                                        a(this).removeClass("selected");
                                        a(this).find('input[type="checkbox"]').removeAttr("checked")
                                    }
                                });
                                a(this).attr("src", prePath + "libs/icons/checkAllOff.gif");
                                a(this).attr("title", "点击全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (i) {}
                            })
                        } else {
                            c.toggle(function () {
                                a(this).parents("table").find("tr").each(function () {
                                    a(this).addClass("selected");
                                    a(this).find('input[type="checkbox"]').attr("checked", "checked")
                                });
                                a(this).attr("src", prePath + "libs/icons/checkAllOn.gif");
                                a(this).attr("title", "取消全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (i) {}
                            }, function () {
                                a(this).parents("table").find("tr").each(function () {
                                    if (a(this).hasClass("selected")) {
                                        a(this).removeClass("selected");
                                        a(this).find('input[type="checkbox"]').removeAttr("checked")
                                    }
                                });
                                a(this).attr("src", prePath + "libs/icons/checkAllOff.gif");
                                a(this).attr("title", "点击全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (i) {}
                            })
                        }
                    }
                    if (a(this).attr("selectRowButtonOnly") == false || a(this).attr("selectRowButtonOnly") == "false") {
                        a(this).find("tr:has(td)").each(function () {
                            a(this).find("td").eq(0).addClass("ali02");
                            a(this).unbind("click");
                            a(this).bind("click", function () {
                                if (a(this).hasClass("selected")) {
                                    a(this).removeClass("selected");
                                    a(this).find("td").eq(0).find('input[type="checkbox"]').attr("checked", false)
                                } else {
                                    a(this).addClass("selected");
                                    a(this).find("td").eq(0).find('input[type="checkbox"]').attr("checked", true)
                                }
                            })
                        })
                    } else {
                        a(this).find("tr:has(td)").find('input[type="checkbox"]').each(function () {
                            a(this).parents("td").addClass("ali02");
                            a(this).unbind("click");
                            a(this).bind("click", function () {
                                if (a(this).parents("tr").hasClass("selected")) {
                                    a(this).parents("tr").removeClass("selected")
                                } else {
                                    a(this).parents("tr").addClass("selected")
                                }
                            })
                        })
                    }
                }
            }
        })
    }
})(jQuery);

function getPosition(c, d) {
    var a = -1;
    for (var b = 0; b < d.length; b++) {
        if (c == d[b]) {
            a = b;
            break
        }
    }
    return a
}
jQuery.fn.extend({
    selectRender: function () {
        return this.each(function () {
            if ($(this).prev("div").hasClass("mainCon")) {
                $(this).prev("div").remove()
            }
            new jQuery.SelectBox(this)
        })
    },
    selectAddItem: function (a) {
        this.each(function () {
            var b = $(this).data("data");
            var c = "list";
            if ($(this).attr("dataRoot")) {
                c = $(this).attr("dataRoot")
            }
            b[c].push(a);
            $(this).data("data", b);
            $(this).prev(".mainCon").remove();
            new jQuery.SelectBox(this)
        })
    },
    selectRemoveItem: function (a) {
        this.each(function () {
            var b = $(this).data("data");
            var c = -1;
            var d = "list";
            if ($(this).attr("dataRoot")) {
                d = $(this).attr("dataRoot")
            }
            $.each(b[d], function (e, f) {
                if (f.value.toString() == a) {
                    c = e
                }
            });
            if (c != -1) {
                b[d].splice(c, 1)
            }
            $(this).data("data", b);
            $(this).prev(".mainCon").remove();
            new jQuery.SelectBox(this)
        })
    }
});
if (!window.console) {
    var console = {
        log: function (a) {}
    }
}
var elm_id = 1;
jQuery.SelectBox = function (H) {
    var i = {};
    i.inputClass = i.inputClass || "selectbox";
    i.containerClass = i.containerClass || "selectbox-wrapper";
    i.hoverClass = i.hoverClass || "current";
    i.currentClass = i.selectedClass || "selected";
    i.debug = i.debug || false;
    elm_id++;
    var g = "0_input";
    var x = "0_button";
    var G = 0;
    var u = false;
    var s = 0;
    var K = $(H);
    var b = t(i);
    var n = e();
    var w = J(i);
    var E = false;
    var m = false;
    var y = 1;
    var q;
    var l;
    var c = 0;
    var L = 0;
    if (window.navigator.userAgent.indexOf("Windows") > -1) {
        c = 1
    }
    l = K.width();
    if (l == "0") {
        l = 116
    }
    var p;
    p = $("<input type='button' value=' ' class='selBtn'/>");
    p.attr("id", elm_id + "_button");
    var r = $("<div class='loader'>数据加载中...</div>");
    if (K.attr("colNum") != null) {
        y = parseInt(K.attr("colNum"))
    }
    if (K.attr("colWidth") != null) {
        q = Number(K.attr("colWidth"))
    } else {
        q = 100
    }
    var h = 99;
    if (K.attr("selWidth") != null) {
        h = Number(K.attr("selWidth")) - 22
    }
    w.width(h);
    K.hide().before(n);
    var O = $('<table cellspacing="0" cellpadding="0" style="border-style:none;"><tr><td class="ali01" style="border-style:none;padding:0;margin:0;"></td><td class="ali01" style="border-style:none;;padding:0;margin:0;"></td></tr></table>');
    O.find("td").eq(0).append(w);
    O.find("td").eq(1).append(p);
    n.append(O);
    n.append(b);
    n.append(r);
    r.hide();
    if (K.attr("disabled") == "disabled" || K.attr("disabled") == "true" || K.attr("disabled") == true) {
        p.attr("disabled", true);
        p.addClass("selBtn_disabled");
        w.addClass("selectbox_disabled")
    }
    I();
    if (K.attr("editable") != null) {
        if (K.attr("editable") == "true") {
            m = true
        } else {
            m = false
        }
    }
    if (!m) {
        w.css({
            cursor: "pointer"
        });
        w.click(function (Q) {
            g = $(Q.target).attr("id");
            B();
            if (b.attr("hasfocus") == 0) {
                o()
            } else {
                a()
            }
        }).keydown(function (Q) {
            switch (Q.keyCode) {
            case 38:
                Q.preventDefault();
                A(-1);
                break;
            case 40:
                Q.preventDefault();
                A(1);
                break;
            case 13:
                Q.preventDefault();
                $("li." + i.hoverClass).trigger("click");
                break;
            case 27:
                a();
                break
            }
        })
    } else {
        w.css({
            cursor: "text"
        });
        w.change(function () {
            K.attr("editValue", $(this).val())
        })
    }
    p.click(function (Q) {
        x = $(Q.target).attr("id");
        B();
        if (b.attr("hasfocus") == 0) {
            o()
        } else {
            a()
        }
    }).keydown(function (Q) {
        switch (Q.keyCode) {
        case 38:
            Q.preventDefault();
            A(-1);
            break;
        case 40:
            Q.preventDefault();
            A(1);
            break;
        case 13:
            Q.preventDefault();
            $("li." + i.hoverClass).trigger("click");
            break;
        case 27:
            a();
            break
        }
    });

    function B() {
        var V;
        var R = b.find("li").length;
        if (y == 1) {
            V = R * 26
        } else {
            if (R % y == 0) {
                V = R * 26 / y
            } else {
                V = (R - R % y) * 26 / y + 26
            }
        }
        b.height(V);
        var Q = 200;
        if (parentTopHeight > 0) {
            var S = window.top.document.documentElement.clientHeight;
            Q = S - parentTopHeight - parentBottomHeight - n.offset().top - 30
        } else {
            Q = window.document.documentElement.clientHeight - (n.offset().top - $(window).scrollTop()) - 30
        }
        var U;
        if (!K.attr("boxWidth")) {
            U = b.width()
        }
        b.css({
            overflowY: "auto",
            overflowX: "hidden"
        });
        if (y != 1) {
            b.width((q + 6) * y)
        } else {
            if (!K.attr("boxWidth")) {
                b.width(U)
            } else {
                b.width(Number(K.attr("boxWidth")) + 1)
            }
        }
        var T = 0;
        if (K.attr("boxHeight")) {
            T = Number(K.attr("boxHeight"))
        }
        if (T != 0) {
            b.height(T);
            if (K.attr("openDirection") == "top") {
                b.css({
                    top: -T
                })
            } else {
                if (K.attr("openDirection") == "bottom") {
                    b.css({
                        top: 24
                    })
                } else {
                    if (Q < T) {
                        if (n.offset().top > T) {
                            b.css({
                                top: -T
                            })
                        } else {
                            if (Q < 100 && n.offset().top > Q && n.offset().top > 100) {
                                b.css({
                                    top: -T
                                })
                            } else {
                                b.css({
                                    top: 24
                                })
                            }
                        }
                    } else {
                        b.css({
                            top: 24
                        })
                    }
                }
            }
        } else {
            if (K.attr("openDirection") == "top") {
                if (n.offset().top > V) {
                    b.css({
                        top: -V
                    })
                } else {
                    b.height(n.offset().top);
                    b.css({
                        top: -V
                    })
                }
            } else {
                if (K.attr("openDirection") == "bottom") {
                    if (Q < V) {
                        b.css({
                            top: 24
                        });
                        b.height(Q)
                    } else {
                        b.css({
                            top: 24
                        })
                    }
                } else {
                    if (Q < V) {
                        if (n.offset().top > V) {
                            b.css({
                                top: -V
                            })
                        } else {
                            if (Q < 100 && n.offset().top > Q && n.offset().top > 100) {
                                b.height(n.offset().top);
                                b.css({
                                    top: -V
                                })
                            } else {
                                b.css({
                                    top: 24
                                });
                                b.height(Q)
                            }
                        }
                    } else {
                        b.css({
                            top: 24
                        })
                    }
                }
            }
        }
        if (!K.attr("boxWidth")) {
            if (b.width() < h + 24) {
                b.width(h + 24)
            }
        }
    }
    function a() {
        b.attr("hasfocus", 0);
        b.hide();
        $("body").unbind("mousedown", M)
    }
    function o() {
        b.attr("hasfocus", 1);
        depth++;
        n.css({
            zIndex: depth
        });
        b.show();
        $("body").bind("mousedown", M)
    }
    function M(Q) {
        if ($(Q.target).attr("id") == g || $(Q.target).attr("id") == x || $(Q.target).parent().attr("class") == "selectbox-wrapper" || $(Q.target).attr("class") == "selectbox-wrapper" || $(Q.target).parents(".selectbox-wrapper").length > 0) {} else {
            a()
        }
    }
    function I() {
        b.append(C(w.attr("id"))).hide();
        var Q = w.css("width")
    }
    function e() {
        var Q = $("<div></div>");
        Q.addClass("mainCon");
        return Q
    }
    function t(Q) {
        var R = $("<div></div>");
        R.attr("id", elm_id + "_container");
        R.addClass(Q.containerClass);
        R.css({});
        R.attr("hasfocus", 0);
        return R
    }
    function J(R) {
        var Q = document.createElement("input");
        var T = $(Q);
        T.attr("id", elm_id + "_input");
        T.attr("type", "text");
        T.addClass(R.inputClass);
        if (broswerFlag == "IE8") {
            T.addClass("selectboxFont")
        }
        T.attr("autocomplete", "off");
        var S = false;
        if (K.attr("editable") != null) {
            if (K.attr("editable") == "true") {
                S = true
            } else {
                S = false
            }
        }
        if (!S) {
            if (broswerFlag == "Firefox") {
                T.attr("contenteditable", false)
            } else {
                T.attr("readonly", "readonly")
            }
        } else {
            T.attr("readonly", false)
        }
        T.attr("tabIndex", K.attr("tabindex"));
        if (K.attr("disabled") == "disabled" || K.attr("disabled") == "true" || K.attr("disabled") == true) {
            T.attr("disabled", true);
            T.addClass("inputDisabled")
        }
        return T
    }
    function A(R) {
        var Q = $("li", b);
        if (!Q || Q.length == 0) {
            return false
        }
        G += R;
        if (G < 0) {
            G = Q.size()
        } else {
            if (G > Q.size()) {
                G = 0
            }
        }
        F(Q, G);
        Q.removeClass(i.hoverClass);
        $(Q[G]).addClass(i.hoverClass)
    }
    function F(R, S) {
        var Q = $(R[S]).get(0);
        var R = b.get(0);
        if (Q.offsetTop + Q.offsetHeight > R.scrollTop + R.clientHeight) {
            R.scrollTop = Q.offsetTop + Q.offsetHeight - R.clientHeight
        } else {
            if (Q.offsetTop < R.scrollTop) {
                R.scrollTop = Q.offsetTop
            }
        }
    }
    function f() {
        var Q = $("li." + i.currentClass, b).get(0);
        var R = (Q.id).split("_");
        var T = R[0].length + R[1].length + 2;
        var U = Q.id;
        var S = U.substr(T, U.length);
        K.val(S);
        K.attr("relText", $(Q).text());
        K.attr("relValue", S);
        var U = $(Q).html().trim();
        w.val(U);
        if (m == true) {
            K.attr("editValue", w.val())
        }
        K.focus();
        return true
    }
    function d() {
        return K.val()
    }
    function P() {
        return w.val()
    }
    function C(U) {
        var W = new Array();
        var aa = document.createElement("ul");
        var R = [];
        var ab = 0;
        var af;
        if (K.attr("childId") != null) {
            af = true
        }
        var ae;
        if (K.attr("editable") != null) {
            if (K.attr("editable") == "true") {
                ae = true
            } else {
                ae = false
            }
        }
        var Q = false;
        var Y = K.attr("url");
        var S = K.attr("data");
        var T = K.data("data");
        if (Y != null || S != null || T != null) {
            Q = true
        }
        if (Q == true) {
            var ad = "list";
            if (K.attr("dataRoot")) {
                ad = K.attr("dataRoot")
            }
            var ac = K.attr("params");
            var X;
            if (ac) {
                try {
                    X = JSON.parse(ac)
                } catch (Z) {
                    X = "";
                    alert("参数格式有误！（提示：放在标签中的json数据的属性和名称必须以双引号包围）")
                }
            } else {
                X = ""
            }
            if (T) {
                D(T, U, y, q, ae, af, aa, ad)
            } else {
                if (S) {
                    var V;
                    try {
                        V = JSON.parse(S)
                    } catch (Z) {
                        V = "";
                        alert("参数格式有误！（提示：json数据key与value必须以双引号包围）")
                    }
                    K.data("data", V);
                    D(V, U, y, q, ae, af, aa, ad)
                } else {
                    if (Y) {
                        $.ajax({
                            url: K.attr("url"),
                            dataType: "json",
                            data: X,
                            error: function () {
                                alert("单选下拉框数据源出错，请检查url路径")
                            },
                            success: function (ag) {
                                K.data("data", ag);
                                D(ag, U, y, q, ae, af, aa, ad)
                            }
                        })
                    }
                }
            }
        } else {
            K.find("option").each(function () {
                R.push($(this)[0]);
                var ag = document.createElement("li");
                ag.setAttribute("id", U + "_" + $(this).val());
                ag.innerHTML = $(this).html();
                if ($(this).is(":selected")) {
                    if (ae == true) {
                        w.val($(this).html());
                        $(ag).addClass(i.currentClass)
                    } else {
                        var ai = $(this).html().trim();
                        w.val(ai);
                        $(ag).addClass(i.currentClass)
                    }
                }
                if (y != 1) {
                    $(ag).addClass("li_left");
                    if (q != null) {
                        $(ag).width(q)
                    } else {
                        var ah = Number(l);
                        $(ag).width(ah)
                    }
                }
                aa.appendChild(ag);
                $(ag).mouseover(function (aj) {
                    s = 1;
                    if (i.debug) {
                        console.log("over on : " + this.id)
                    }
                    jQuery(aj.target, b).addClass(i.hoverClass)
                }).mouseout(function (aj) {
                    s = -1;
                    if (i.debug) {
                        console.log("out on : " + this.id)
                    }
                    jQuery(aj.target, b).removeClass(i.hoverClass)
                }).click(function (ak) {
                    var al = $("li." + i.hoverClass, b).get(0);
                    if (i.debug) {
                        console.log("click on :" + this.id)
                    }
                    var aj = $(this).attr("id").split("_");
                    $("#" + aj[0] + "_container li." + i.currentClass).removeClass(i.currentClass);
                    $(this).addClass(i.currentClass);
                    f();
                    K.get(0).blur();
                    a();
                    try {
                        K.trigger("change")
                    } catch (am) {}
                    w.removeClass("tipColor");
                    if (af) {
                        z(K, K.val())
                    }
                });
                if (K.attr("editValue") != null) {
                    w.val(K.attr("editValue"))
                }
            })
        }
        K.find("optgroup").each(function () {
            var ah = getPosition($(this).children("option").eq(0)[0], R);
            var ag = $(this).attr("label");
            $(aa).find("li").eq(ah + ab).before("<li class='group'>" + ag + "</li>");
            ab++
        });
        return aa
    }
    function D(V, T, R, W, ac, ad, Z, aa, X) {
        if (!V) {
            return
        }
        var Q = "请选择";
        if (K.attr("prompt") != null) {
            if (K.attr("prompt") == "") {
                Q = "请选择"
            } else {
                Q = K.attr("prompt")
            }
        }
        var U = -1;
        var Y = "";
        if (K.attr("selectedIdx")) {
            U = Number(K.attr("selectedIdx"))
        }
        if (K.attr("selectedValue")) {
            Y = K.attr("selectedValue")
        }
        K.attr("length", 10);
        if (K.attr("prompt") != null) {
            var ab = document.createElement("li");
            ab.setAttribute("id", T + "_");
            ab.innerHTML = Q;
            if (U == -1 && Y == "") {
                $(ab).addClass(i.currentClass);
                w.val(ab.innerHTML)
            }
            Z.appendChild(ab);
            K[0].options.length = 0;
            K[0].options[K[0].options.length] = new Option(Q, "");
            if (R != 1) {
                $(ab).addClass("li_left");
                if (W != null) {
                    $(ab).width(W)
                } else {
                    var S = Number(l);
                    $(ab).width(S)
                }
            }
            $(ab).mouseover(function (ae) {
                s = 1;
                if (i.debug) {
                    console.log("over on : " + this.id)
                }
                jQuery(ae.target, b).addClass(i.hoverClass)
            }).mouseout(function (ae) {
                s = -1;
                if (i.debug) {
                    console.log("out on : " + this.id)
                }
                jQuery(ae.target, b).removeClass(i.hoverClass)
            }).click(function (af) {
                var ag = $("li." + i.hoverClass, b).get(0);
                if (i.debug) {
                    console.log("click on :" + this.id)
                }
                var ae = $(this).attr("id").split("_");
                $("#" + ae[0] + "_container li." + i.currentClass).removeClass(i.currentClass);
                $(this).addClass(i.currentClass);
                f();
                K.get(0).blur();
                a();
                K.trigger("change");
                w.removeClass("tipColor")
            })
        }
        if (K.attr("prompt") == null) {
            if (U == -1 && Y == "") {
                U = 0
            }
        }
        $.each(V[aa], function (af, ah) {
            var ae = document.createElement("li");
            ae.setAttribute("id", T + "_" + ah.value);
            ae.innerHTML = ah.key;
            K[0].options[K[0].options.length] = new Option(ah.key, ah.value);
            if (U == af) {
                if (ac == true) {
                    $(ae).addClass(i.currentClass);
                    w.val(ae.innerHTML);
                    K.val(ah.value);
                    K.attr("relText", ah.key);
                    K.attr("editValue", ah.key)
                } else {
                    $(ae).addClass(i.currentClass);
                    w.val(ae.innerHTML.trim());
                    K.val(ah.value);
                    K.attr("relText", ah.key);
                    K.attr("relValue", ah.value)
                }
            } else {
                if (Y != "") {
                    if (Y == ah.value.toString()) {
                        if (ac == true) {
                            $(ae).addClass(i.currentClass);
                            w.val(ae.innerHTML);
                            K.val(ah.value);
                            K.attr("relText", ah.key);
                            K.attr("editValue", ah.key)
                        } else {
                            $(ae).addClass(i.currentClass);
                            w.val(ae.innerHTML.trim());
                            K.val(ah.value);
                            K.attr("relText", ah.key);
                            K.attr("relValue", ah.value)
                        }
                    }
                }
            }
            if (R != 1) {
                $(ae).addClass("li_left");
                if (W != null) {
                    $(ae).width(W)
                } else {
                    var ag = Number(l);
                    $(ae).width(ag)
                }
            }
            $(ae).mouseover(function (ai) {
                s = 1;
                if (i.debug) {
                    console.log("over on : " + this.id)
                }
                jQuery(ai.target, b).addClass(i.hoverClass)
            }).mouseout(function (ai) {
                s = -1;
                if (i.debug) {
                    console.log("out on : " + this.id)
                }
                jQuery(ai.target, b).removeClass(i.hoverClass)
            }).click(function (aj) {
                var ak = $("li." + i.hoverClass, b).get(0);
                if (i.debug) {
                    console.log("click on :" + this.id)
                }
                var ai = $(this).attr("id").split("_");
                $("#" + ai[0] + "_container li." + i.currentClass).removeClass(i.currentClass);
                $(this).addClass(i.currentClass);
                f();
                K.get(0).blur();
                a();
                try {
                    K.trigger("change")
                } catch (al) {}
                w.removeClass("tipColor");
                if (ad) {
                    z(K, K.val())
                }
            });
            Z.appendChild(ae);
            if (K.attr("editValue") != null) {
                w.val(K.attr("editValue"))
            }
        });
        K.attr("finished", "true")
    }
    function z(S, R) {
        if (R != "") {
            var T = S.attr("childId");
            var Q = $("#" + T).prev().find("div[class=loader]");
            Q.show();
            window.setTimeout(function () {
                N(S, R)
            }, 200)
        }
    }
    function N(S, R) {
        var Q;
        if (S.attr("childDataType") == null) {
            Q = S.attr("childDataPath") + R
        } else {
            if (S.attr("childActionType") == "local") {
                Q = S.attr("childDataPath") + R + "." + S.attr("childDataType")
            } else {
                Q = S.attr("childDataPath") + R
            }
        }
        if (S.attr("childDataType") == "xml") {
            $.ajax({
                url: Q,
                error: function () {
                    try {
                        top.Dialog.alert("数据加载失败，请检查childDataPath是否正确")
                    } catch (T) {
                        alert("数据加载失败，请检查childDataPath是否正确")
                    }
                },
                success: function (W) {
                    var T = S.attr("childId");
                    var ab = $("#" + T).prev().find("div[class=loader]");
                    ab.hide();
                    var Z = $("#" + T).prev().find("ul");
                    var V = $("#" + T).prev().find(">div").attr("id").split("_")[0];
                    var U = $("#" + T).prev().find("input:text");
                    var X = $("#" + T)[0];
                    Z.html("");
                    X.options.length = 0;
                    $(W).find("node").each(function () {
                        var ae = $(this).attr("text");
                        var ad = $(this).attr("value");
                        var ac = document.createElement("li");
                        $(ac).text(ae);
                        $(ac).attr("relValue", ad);
                        Z.append($(ac));
                        X.options[X.options.length] = new Option(ae, ad);
                        $(ac).mouseover(function (af) {
                            jQuery(af.target).addClass(i.hoverClass)
                        });
                        $(ac).mouseout(function (af) {
                            jQuery(af.target).removeClass(i.hoverClass)
                        });
                        $(ac).mousedown(function (ag) {
                            $("#" + V + "_container li." + i.currentClass).removeClass(i.currentClass);
                            $(this).addClass(i.currentClass);
                            $("#" + T).attr("relText", $(this).text());
                            $("#" + T).attr("relValue", $(this).attr("relValue"));
                            $("#" + T).val($(this).attr("relValue"));
                            U.val($(this).html());
                            $("#" + T).prev().find(">div").hide();
                            $("#" + T).focus();
                            if ($("#" + T).attr("onchange") != null) {}
                            try {
                                $("#" + T).trigger("change")
                            } catch (ah) {}
                            var af;
                            if ($("#" + T).attr("childId") != null) {
                                af = true
                            }
                            if (af) {
                                z($("#" + T), $("#" + T).val())
                            }
                        })
                    });
                    if ($(W).find("node").length == 0) {
                        var aa = document.createElement("li");
                        $(aa).text("无内容");
                        Z.append($(aa))
                    }
                    var Y = Z.find("li").eq(0);
                    U.val(Y.text());
                    Y.addClass(i.currentClass);
                    $("#" + T).val(Y.attr("relValue"));
                    $("#" + T).attr("relValue", Y.attr("relValue"));
                    $("#" + T).attr("relText", Y.text());
                    $("#" + T).trigger("ajaxInit")
                }
            })
        } else {
            $.getJSON(Q, function (V) {
                var W = S.attr("childId");
                var Y = $("#" + W).prev().find("div[class=loader]");
                Y.hide();
                var ae = $("#" + W).prev().find("ul");
                var X = $("#" + W).prev().find(">div").attr("id").split("_")[0];
                var ac = $("#" + W).prev().find("input:text");
                var T = $("#" + W)[0];
                ae.html("");
                T.options.length = 0;
                var Z = "list";
                if ($("#" + W).attr("dataRoot")) {
                    Z = $("#" + W).attr("dataRoot")
                }
                if ($("#" + W).attr("prompt")) {
                    var aa = document.createElement("li");
                    var ab = $("#" + W).attr("prompt");
                    $(aa).text(ab);
                    $(aa).attr("relValue", "");
                    ae.append($(aa));
                    T.options[T.options.length] = new Option(ab, "");
                    $(aa).mouseover(function (af) {
                        jQuery(af.target).addClass(i.hoverClass)
                    });
                    $(aa).mouseout(function (af) {
                        jQuery(af.target).removeClass(i.hoverClass)
                    });
                    $(aa).mousedown(function (af) {
                        $("#" + X + "_container li." + i.currentClass).removeClass(i.currentClass);
                        $(this).addClass(i.currentClass);
                        $("#" + W).attr("relText", $(this).text());
                        $("#" + W).attr("relValue", $(this).attr("relValue"));
                        $("#" + W).val($(this).attr("relValue"));
                        ac.val($(this).html());
                        $("#" + W).prev().find(">div").hide();
                        $("#" + W).focus();
                        if ($("#" + W).attr("onchange") != null) {}
                        try {
                            $("#" + W).trigger("change")
                        } catch (ag) {}
                    })
                }
                $.each(V[Z], function (af, ai) {
                    var ag = ai.key;
                    var ah = ai.value;
                    var aj = document.createElement("li");
                    $(aj).text(ag);
                    $(aj).attr("relValue", ah);
                    ae.append($(aj));
                    T.options[T.options.length] = new Option(ag, ah);
                    $(aj).mouseover(function (ak) {
                        jQuery(ak.target).addClass(i.hoverClass)
                    });
                    $(aj).mouseout(function (ak) {
                        jQuery(ak.target).removeClass(i.hoverClass)
                    });
                    $(aj).mousedown(function (ak) {
                        $("#" + X + "_container li." + i.currentClass).removeClass(i.currentClass);
                        $(this).addClass(i.currentClass);
                        $("#" + W).attr("relText", $(this).text());
                        $("#" + W).attr("relValue", $(this).attr("relValue"));
                        $("#" + W).val($(this).attr("relValue"));
                        ac.val($(this).html());
                        $("#" + W).prev().find(">div").hide();
                        $("#" + W).focus();
                        if ($("#" + W).attr("onchange") != null) {}
                        try {
                            $("#" + W).trigger("change")
                        } catch (al) {}
                        var am;
                        if ($("#" + W).attr("childId") != null) {
                            am = true
                        }
                        if (am) {
                            z($("#" + W), $("#" + W).val())
                        }
                    })
                });
                if (V.length == 0) {
                    var ad = document.createElement("li");
                    $(ad).text("无内容");
                    ae.append($(ad))
                }
                var U = ae.find("li").eq(0);
                ac.val(U.text());
                U.addClass(i.currentClass);
                $("#" + W).val(U.attr("relValue"));
                $("#" + W).attr("relValue", U.attr("relValue"));
                $("#" + W).attr("relText", U.text());
                $("#" + W).trigger("ajaxInit")
            })
        }
    }
};
var tipDirection = "down";

function enableTooltips(e) {
    var b, a, c, d;
    if (!document.getElementById || !document.getElementsByTagName) {
        return
    }
    AddCss();
    d = document.createElement("span");
    d.id = "btc";
    d.setAttribute("id", "btc");
    d.style.position = "absolute";
    d.style.zIndex = 9999;
    $("body").append($(d));
    $("a[title],span[title],input[title],textarea[title],img[title],div[title]").each(function () {
        if ($(this).attr("keepDefaultStyle") == "true" || $(this).attr("keepDefaultStyle") == true || $(this).parents(".selectbox-tree").length > 0) {} else {
            Prepare($(this)[0])
        }
    })
}
function _getStrLength(c) {
    var b;
    var a;
    for (b = 0, a = 0; b < c.length; b++) {
        if (c.charCodeAt(b) < 128) {
            a++
        } else {
            a = a + 2
        }
    }
    return a
}
function Prepare(f) {
    var g, d, a, e, c;
    d = f.getAttribute("title");
    if (d == " ") {
        f.removeAttribute("title");
        f.onmouseover = null;
        f.onmouseout = null;
        f.onmousemove = null;
        return
    }
    if (d != null && d.length != 0) {
        f.removeAttribute("title");
        if (_getStrLength(d) > 37 || _getStrLength(d) == 37) {
            g = CreateEl("span", "tooltip")
        } else {
            if (_getStrLength(d) > 10 && _getStrLength(d) < 37) {
                g = CreateEl("span", "tooltip_mid")
            } else {
                g = CreateEl("span", "tooltip_min")
            }
        }
        e = CreateEl("span", "top");
        $(e).html(d);
        g.appendChild(e);
        a = CreateEl("b", "bottom");
        g.appendChild(a);
        setOpacity(g);
        f.tooltip = g;
        f.onmouseover = showTooltip;
        f.onmouseout = hideTooltip;
        f.onmousemove = Locate2
    }
}
function hideTip(a) {
    var b = document.getElementById("btc");
    if (b.childNodes.length > 0) {
        b.removeChild(b.firstChild)
    }
}
function showTooltip(a) {
    document.getElementById("btc").appendChild(this.tooltip);
    Locate(a)
}
function hideTooltip() {
    var a = document.getElementById("btc");
    if (a.childNodes.length > 0) {
        a.removeChild(a.firstChild)
    }
}
function setOpacity(a) {
    a.style.filter = "alpha(opacity:95)";
    a.style.KHTMLOpacity = "0.95";
    a.style.MozOpacity = "0.95";
    a.style.opacity = "0.95"
}
function CreateEl(b, d) {
    var a = document.createElement(b);
    a.className = d;
    a.style.display = "block";
    return (a)
}
function AddCss() {}
function Locate(g) {
    var a = 0,
        i = 0;
    if (g == null) {
            g = window.event
        }
    if (g.pageX || g.pageY) {
            a = g.pageX;
            i = g.pageY
        } else {
            if (g.clientX || g.clientY) {
                if (document.documentElement.scrollTop) {
                    a = g.clientX + document.documentElement.scrollLeft;
                    i = g.clientY + document.documentElement.scrollTop
                } else {
                    a = g.clientX + document.body.scrollLeft;
                    i = g.clientY + document.body.scrollTop
                }
            }
        }
    var h = window.document.documentElement.clientWidth;
    var c = window.document.documentElement.clientHeight;
    var b = $("#btc").width();
    var f = $("#btc").height();
    var d = $("#btc >span")[0].className;
    if (h - b < a - 20) {
            document.getElementById("btc").style.left = (h - b) + "px";
            if (d == "tooltip") {
                $("#btc >span")[0].className = "tooltip_s"
            } else {
                if (d == "tooltip_min") {
                    $("#btc >span")[0].className = "tooltip_min_s"
                } else {
                    if (d == "tooltip_mid") {
                        $("#btc >span")[0].className = "tooltip_mid_s"
                    }
                }
            }
        } else {
            document.getElementById("btc").style.left = (a - 20) + "px"
        }
    if ($(window).scrollTop() + c - f < i) {
            document.getElementById("btc").style.top = (i - f - 10) + "px";
            if (d == "tooltip") {
                $("#btc >span")[0].className = "tooltip_r"
            } else {
                if (d == "tooltip_min") {
                    $("#btc >span")[0].className = "tooltip_min_r"
                } else {
                    if (d == "tooltip_mid") {
                        $("#btc >span")[0].className = "tooltip_mid_r"
                    }
                }
            }
            tipDirection = "up"
        } else {
            document.getElementById("btc").style.top = (i + 10) + "px";
            if (d == "tooltip_r") {
                $("#btc >span")[0].className = "tooltip"
            } else {
                if (d == "tooltip_min_r") {
                    $("#btc >span")[0].className = "tooltip_min"
                } else {
                    if (d == "tooltip_mid_r") {
                        $("#btc >span")[0].className = "tooltip_mid"
                    }
                }
            }
            tipDirection = "down"
        }
}
function Locate2(f) {
    var a = 0,
        h = 0;
    if (f == null) {
            f = window.event
        }
    if (f.pageX || f.pageY) {
            a = f.pageX;
            h = f.pageY
        } else {
            if (f.clientX || f.clientY) {
                if (document.documentElement.scrollTop) {
                    a = f.clientX + document.documentElement.scrollLeft;
                    h = f.clientY + document.documentElement.scrollTop
                } else {
                    a = f.clientX + document.body.scrollLeft;
                    h = f.clientY + document.body.scrollTop
                }
            }
        }
    var g = window.document.documentElement.clientWidth;
    var c = window.document.documentElement.clientHeight;
    var b = $("#btc").width();
    var d = $("#btc").height();
    if (g - b < a - 20) {
            document.getElementById("btc").style.left = (g - b) + "px"
        } else {
            document.getElementById("btc").style.left = (a - 20) + "px"
        }
    if (tipDirection == "up") {
            document.getElementById("btc").style.top = (h - d - 10) + "px"
        } else {
            document.getElementById("btc").style.top = (h + 10) + "px"
        }
}(function (c) {
    var h, i;
    var d = 0;
    var a = 32;
    var e;
    c.fn.TextAreaResizer = function () {
        return this.each(function () {
            h = c(this).addClass("processed"),
            i = null;
            c(this).wrap('<div class="resizable-textarea"><span></span></div>').parent().append(c('<div class="grippie"></div>').bind("mousedown", {
                el: this
            }, b)).wrap('<table cellspacing="0" cellpadding="0" style="border-style:none;"><tr><td class="ali01" style="border-style:none;padding:0;margin:0;"></td></tr></table>');
            var m = c("div.grippie", c(this).parent())
        })
    };

    function b(m) {
        h = c(m.data.el);
        h.blur();
        d = l(m).y;
        i = h.height() - d;
        h.css("opacity", 0.25);
        c(document).mousemove(g).mouseup(f);
        return false
    }
    function g(o) {
        var m = l(o).y;
        var n = i + m;
        if (d >= (m)) {
            n -= 5
        }
        d = m;
        n = Math.max(a, n);
        h.height(n + "px");
        if (n < a) {
            f(o)
        }
        return false
    }
    function f(m) {
        c(document).unbind("mousemove", g).unbind("mouseup", f);
        h.css("opacity", 1);
        h.focus();
        h = null;
        i = null;
        d = 0
    }
    function l(m) {
        return {
            x: m.clientX + document.documentElement.scrollLeft,
            y: m.clientY + document.documentElement.scrollTop
        }
    }
})(jQuery);
(function (a) {
    a.fn.watermark = function (b, c) {
        return this.each(function () {
            var e = a(this),
                d;
            e.focus(function () {
                    d && !(d = 0) && e.removeClass(b).data("w", 0).val("")
                }).blur(function () {
                    !e.val() && (d = 1) && e.addClass(b).data("w", 1).val(c)
                }).closest("form").submit(function () {
                    d && e.val("")
                });
            e.blur()
        })
    };
    a.fn.removeWatermark = function () {
        return this.each(function () {
            a(this).data("w") && a(this).val("")
        })
    }
})(jQuery);
if (jQuery) {
    (function (a) {
        a.cursorMessageData = {};
        a(window).ready(function (b) {
            if (a("#cursorMessageDiv").length == 0) {
                a("body").append('<div id="cursorMessageDiv">&nbsp;</div>');
                a("#cursorMessageDiv").hide()
            }
            a("body").mousemove(function (c) {
                a.cursorMessageData.mouseX = c.pageX;
                a.cursorMessageData.mouseY = c.pageY;
                if (a.cursorMessageData.options != undefined) {
                    a._showCursorMessage()
                }
            })
        });
        a.extend({
            cursorMessage: function (c, b) {
                if (b == undefined) {
                    b = {}
                }
                if (b.offsetX == undefined) {
                    b.offsetX = 5
                }
                if (b.offsetY == undefined) {
                    b.offsetY = 5
                }
                if (b.hideTimeout == undefined) {
                    b.hideTimeout = 3000
                }
                a("#cursorMessageDiv").html(c).fadeIn("slow");
                if (jQuery.cursorMessageData.hideTimeoutId != undefined) {
                    clearTimeout(jQuery.cursorMessageData.hideTimeoutId)
                }
                if (b.hideTimeout > 0) {
                    jQuery.cursorMessageData.hideTimeoutId = setTimeout(a.hideCursorMessage, b.hideTimeout)
                }
                jQuery.cursorMessageData.options = b;
                a._showCursorMessage()
            },
            hideCursorMessage: function () {
                a("#cursorMessageDiv").fadeOut("slow")
            },
            _showCursorMessage: function () {
                a("#cursorMessageDiv").css({
                    top: (a.cursorMessageData.mouseY + a.cursorMessageData.options.offsetY) + "px",
                    left: (a.cursorMessageData.mouseX + a.cursorMessageData.options.offsetX)
                })
            }
        })
    })(jQuery)
}
jQuery.fn.caps = function (a) {
    return this.keypress(function (f) {
        var b = f.which ? f.which : (f.keyCode ? f.keyCode : -1);
        var d = f.shiftKey ? f.shiftKey : (f.modifiers ? !! (f.modifiers & 4) : false);
        var g = ((b >= 65 && b <= 90) && !d) || ((b >= 97 && b <= 122) && d);
        a.call(this, g)
    })
};

function iframeHeight(b) {
    var a = document.getElementById(b);
    a.style.height = a.contentWindow.document.body.scrollHeight + "px"
}
function winScrollContent(c) {
    var b = $(top.document.getElementById("_Container_" + c)).height();
    $(top.document.getElementById("_DialogFrame_" + c)).attr("scrolling", "no");
    $("#winScrollContent").css({
        overflowY: "auto",
        overflowX: "hidden"
    });
    var a = 0;
    $("#winScrollContent").parent().find(">div").not("#winScrollContent").each(function () {
        if ($(this).css("display") != "none") {
            a = a + $(this).outerHeight();
            if ($(this).css("marginBottom") != "auto") {
                a = a + parseInt($(this).css("marginBottom"))
            }
            if ($(this).css("marginTop") != "auto") {
                a = a + parseInt($(this).css("marginTop"))
            }
        }
    });
    if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
        $("#winScrollContent").height(b - a - 10)
    } else {
        $("#winScrollContent").height(b - a + 5)
    }
}(function (a) {
    a.fileRender = {
        defaults: {
            button_text: " ",
            class_container: "fileupload-rebrush",
            class_field: "fileupload-rebrush-field",
            class_button: "fileupload-rebrush-button"
        }
    };
    a.fn.extend({
        fileRender: function (d) {
            a(this).attr("contenteditable", false);
            d = a.extend({}, a.fileRender.defaults, d);
            var e = ["padding-left", "padding-right", "margin-left", "margin-right", "border-left-width", "border-right-width"];
            a(this).wrap('<div class="file-container"/>');
            var g = a(this).parent();
            g.prepend('<table cellspacing="0" cellpadding="0" style="border-style:none;"><tr><td class="ali01" style="border-style:none;padding:0;margin:0;"><input type="text" class="textinput" value="" readonly="readonly" /></td><td class="ali01" style="border-style:none;;padding:0;margin:0;"><input type="button" class="fileBtn" value="' + d.button_text + '" /></td></tr></table>');
            var i = g.find("input[type=text]");
            var b = g.find("input[type=button]");
            var f = 0;
            for (var h in e) {
                var c = Math.round(parseFloat(i.css(e[h]) + 0)) + 0;
                var l = Math.round(parseFloat(b.css(e[h]) + 0)) + 0;
                f += (isNaN(c) ? 0 : c) + (isNaN(l) ? 0 : l)
            }
            f += Math.round(parseFloat(i.width())) + Math.round(parseFloat(b.width()));
            if (a.browser.msie) {
                a(this).width(180)
            } else {
                a(this).width(120)
            }
            a(this).height(25);
            i.width(120);
            g.css({
                position: "relative",
                overflow: "hidden"
            });
            a(this).css({
                position: "absolute",
                "z-index": 2,
                "font-size": "12px",
                opacity: "0",
                left: "0px",
                top: "0px"
            });
            a(this).change(function () {
                a(this).parent().find("input[type=text]").val(a(this).val());
                if (a(this).attr("showInfo") != "false") {
                    try {
                        a(this).attr("title", a(this).val());
                        enableTooltips()
                    } catch (m) {}
                }
            })
        }
    })
})(jQuery);
(function (d) {
    d.fn.clearableTextField = function () {
        if (d(this).length > 0) {
            d(this).bind("keyup change paste cut", e);
            for (var f = 0; f < d(this).length; f++) {
                c(d(d(this)[f]))
            }
        }
    };

    function e() {
        c(d(this))
    }
    function c(f) {
        if (f.val().length > 0) {
            b(f)
        } else {
            a(f)
        }
    }
    function b(i) {
        if (!i.next().hasClass("text_clear_button")) {
            i.after("<div class='text_clear_button'></div>");
            var f = i.next();
            var g = f.outerHeight(),
                m = f.outerHeight();
            i.css("padding-right", parseInt(i.css("padding-right")) + g + 1);
            i.width(i.width() - g - 1);
            var o = i.position();
            var l = {};
            l.left = o.left + i.outerWidth(false) - (g + 2);
            var n = Math.round((i.outerHeight(true) - m) / 2);
            l.top = o.top + d("#scrollContent").scrollTop() + n;
            f.css(l);
            f.click(function () {
                    i.val("");
                    c(i)
                })
        }
    }
    function a(h) {
        var f = h.next();
        if (f.hasClass("text_clear_button")) {
            f.remove();
            var g = f.width();
            h.css("padding-right", parseInt(h.css("padding-right")) - g - 1);
            h.width(h.width() + g + 1)
        }
    }
})(jQuery);
(function (a) {
    a.fn.maxlength = function (b) {
        var c = jQuery.extend({
            events: [],
            maxCharacters: 10,
            status: true,
            statusClass: "maxNum",
            statusText: "剩余字数",
            notificationClass: "notification",
            showAlert: false,
            alertText: "输入字符超出限制.",
            slider: true
        }, b);
        a.merge(c.events, ["keyup"]);
        return this.each(function () {
            var g = a(this);
            var l = a(this).val().length;

            function d() {
                var m = c.maxCharacters - l;
                if (m < 0) {
                    m = 0
                }
                g.next("div").html(c.statusText + " :" + m)
            }
            function e() {
                var m = true;
                if (l >= c.maxCharacters) {
                    m = false;
                    g.addClass(c.notificationClass);
                    g.val(g.val().substr(0, c.maxCharacters));
                    i()
                } else {
                    if (g.hasClass(c.notificationClass)) {
                        g.removeClass(c.notificationClass)
                    }
                }
                if (c.status) {
                    d()
                }
            }
            function i() {
                if (c.showAlert) {
                    alert(c.alertText)
                }
            }
            function f() {
                var m = false;
                if (g.is("textarea")) {
                    m = true
                } else {
                    if (g.filter("input[type=text]")) {
                        m = true
                    } else {
                        if (g.filter("input[type=password]")) {
                            m = true
                        }
                    }
                }
                return m
            }
            if (!f()) {
                return false
            }
            a.each(c.events, function (m, o) {
                g.bind(o, function (n) {
                    l = g.val().length;
                    e()
                })
            });
            if (c.status) {
                g.after(a("<div/>").addClass(c.statusClass).html("-"));
                d()
            }
            if (!c.status) {
                var h = g.next("div." + c.statusClass);
                if (h) {
                    h.remove()
                }
            }
            if (c.slider) {
                g.next().hide();
                g.focus(function () {
                    g.next().slideDown("fast")
                });
                g.blur(function () {
                    g.next().slideUp("fast")
                })
            }
        })
    }
})(jQuery);
var colsDefault = 0;
var rowsDefault = 5;

function setDefaultValues(a) {
    colsDefault = a.cols;
    rowsDefault = $(a).attr("rows")
}
function bindEvents(a) {
    a.onkeyup = function () {
        grow(a)
    }
}
function grow(d) {
    var c = 0;
    var a = d.value.split("\n");
    for (var b = a.length - 1; b >= 0; --b) {
        c += Math.floor((a[b].length / colsDefault) + 1)
    }
    if (c >= rowsDefault) {
        d.rows = c + 1
    } else {
        d.rows = rowsDefault
    }
}
jQuery.fn.autoGrow = function () {
    return this.each(function () {
        setDefaultValues(this);
        bindEvents(this)
    })
};



function closeProgress() {
    try {
        if (top.progressFlag == 1) {
            top.Dialog.close();
            top.progressFlag = 0
        } else {
            if (top.progressFlag == 2) {
                top.hideSimpleProgress();
                top.progressFlag = 0
            }
        }
    } catch (a) {}
}
function _initComplete() {
    try {
        initComplete()
    } catch (a) {}
}

