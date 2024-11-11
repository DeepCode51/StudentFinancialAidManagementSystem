var parentTopHeight;
var broswerFlag;
var sigleSelectionSetting = {
    view: {
        dblClickExpand: false,
        selectedMulti: false
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        onClick: zTreeSelectItemClick
    }
};
var multiNoGroupSelectionSetting = {
    view: {
        selectedMulti: true,
        showIcon: false,
        showLine: false
    },
    check: {
        enable: true,
        chkboxType: {
            Y: "",
            N: ""
        }
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        onClick: zTreeSelectItemClick
    }
};
var multiTreeSelectionSetting = {
    view: {
        selectedMulti: false
    },
    check: {
        enable: true,
        chkboxType: {
            Y: "",
            N: ""
        }
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        onClick: zTreeSelectItemClick
    }
};
var multiTreeSelectionSetting2 = {
    view: {
        selectedMulti: false
    },
    check: {
        enable: true,
        chkboxType: {
            Y: "ps",
            N: "ps"
        }
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        onClick: zTreeSelectItemClick
    }
};
jQuery.fn.extend({
    selectTreeRender: function (a) {
        return this.each(function () {
            $(this).html("");
            new jQuery.SelectTreeBox(this, a)
        })
    },
    selectTreeAddItem: function (a) {
        this.each(function () {
            var b = $(this).data("data");
            var c = "treeNodes";
            if ($(this).attr("dataRoot")) {
                c = $(this).attr("dataRoot")
            }
            b[c].push(a);
            $(this).data("data", b);
            $(this).html("");
            new jQuery.SelectTreeBox(this)
        })
    },
    selectTreeRemoveItem: function (a) {
        this.each(function () {
            var b = $(this).data("data");
            var c = -1;
            var d = "treeNodes";
            if ($(this).attr("dataRoot")) {
                d = $(this).attr("dataRoot")
            }
            $.each(b[d], function (e, f) {
                if (f.id.toString() == a) {
                    c = e
                }
            });
            if (c != -1) {
                b[d].splice(c, 1)
            }
            $(this).data("data", b);
            $(this).html("");
            new jQuery.SelectTreeBox(this)
        })
    }
});
var depth = 500;
var selectTree_id = 1;
jQuery.SelectTreeBox = function (F, H) {
    var o = {};
    o.inputClass = o.inputClass || "selectbox";
    o.containerClass = o.containerClass || "selectbox-tree";
    o.hoverClass = o.hoverClass || "current";
    o.currentClass = o.selectedClass || "selected";
    o.debug = o.debug || false;
    selectTree_id++;
    var g = "请选择";
    var k = "0_input";
    var w = "0_button";
    var u = false;
    var I = $(F);
    I.addClass("mainCon");
    if (I.attr("prompt") != null) {
        g = I.attr("prompt")
    }
    var f = t(o);
    var c = $('<ul class="ztree"></ul>');
    c.attr("id", "selectTree" + selectTree_id + "_tree");
    var v = G(o);
    var p = D(o);
    var s;
    s = $("<input type='button' value=' ' class='selBtn'/>");
    var a = false;
    if (I.attr("multiMode") != null) {
        if (I.attr("multiMode") == "true" || I.attr("multiMode") == true) {
            a = true;
            s.addClass("selBtnMuiti");
            if (I.attr("noGroup") == "true" || I.attr("noGroup") == true) {
                c.addClass("noGroupZtree")
            } else {
                c.addClass("multiSelectZtree")
            }
        } else {
            a = false
        }
    }
    if (I.attr("disabled") == "disabled" || I.attr("disabled") == "true" || I.attr("disabled") == true) {
        s.attr("disabled", true);
        if (a == true) {
            s.addClass("selBtn_disabledMuiti")
        } else {
            s.addClass("selBtn_disabled")
        }
        v.addClass("selectbox_disabled")
    }
    s.attr("id", "selectTree" + selectTree_id + "_button");
    var m = 135;
    if (I.attr("selWidth") != null) {
        m = Number(I.attr("selWidth")) - 22
    }
    v.width(m);
    var L = $('<table cellspacing="0" cellpadding="0" style="border-style:none;"><tr><td class="ali01" style="border-style:none;padding:0;margin:0;"></td><td class="ali01" style="border-style:none;;padding:0;margin:0;"></td></tr></table>');
    L.find("td").eq(0).append(v);
    L.find("td").eq(1).append(s);
    I.append(L);
    I.append(f);
    I.append(p);
    f.append(c);
    var C = "";
    if (I.attr("selectedValue")) {
        C = I.attr("selectedValue")
    }
    var q = false;
    if (I.attr("editable") != null) {
        if (I.attr("editable") == "true") {
            q = true
        } else {
            q = false
        }
    }
    f.hide();
    var z = "treeNodes";
    if (I.attr("dataRoot")) {
        z = I.attr("dataRoot")
    }
    var n = I.attr("params");
    var A;
    if (n) {
        try {
            A = JSON.parse(n)
        } catch (K) {
            A = "";
            alert("树形下拉框参数格式有误！（提示：json数据的属性和名称必须以双引号包围）")
        }
    } else {
        A = ""
    }
    var d = "";
    var E = I.attr("url");
    var x = I.attr("data");
    var l = I.data("data");
    if (l) {
        B(l)
    } else {
        if (x) {
            try {
                d = JSON.parse(x)
            } catch (K) {
                d = "";
                alert("树形下拉框参数格式有误！（提示：放在标签中的json数据的属性和名称必须以双引号包围）")
            }
            I.data("data", d);
            B(d)
        } else {
            if (E) {
                $.ajax({
                    url: I.attr("url"),
                    dataType: "json",
                    data: A,
                    error: function () {
                        alert("树形下拉框数据源出错，请检查url路径")
                    },
                    success: function (e) {
                        I.data("data", e);
                        d = e;
                        B(e)
                    }
                })
            }
        }
    }
    if (!q) {
        v.css({
            cursor: "pointer"
        });
        v.click(function (e) {
            k = $(e.target).attr("id");
            y();
            depth++;
            I.css({
                zIndex: depth
            });
            if (f.attr("hasfocus") == 0) {
                r()
            } else {
                b()
            }
        })
    } else {
        v.css({
            cursor: "text"
        });
        v.change(function () {
            I.attr("editValue", $(this).val());
            p.val($(this).val())
        })
    }
    s.click(function (e) {
        w = $(e.target).attr("id");
        y();
        depth++;
        I.css({
            zIndex: depth
        });
        if (f.attr("hasfocus") == 0) {
            r()
        } else {
            b()
        }
    });

    function y() {
        f.css({
            overflowY: "visible",
            overflowX: "visible"
        });
        f.width("");
        var e = 200;
        if (parentTopHeight > 0) {
            var N = window.top.document.documentElement.clientHeight;
            e = N - parentTopHeight - parentBottomHeight - I.offset().top - 30
        } else {
            e = window.document.documentElement.clientHeight - (I.offset().top - $(window).scrollTop()) - 30
        }
        var P;
        if (!I.attr("boxWidth")) {
            P = f.width()
        }
        f.css({
            overflowY: "auto",
            overflowX: "hidden"
        });
        if (!I.attr("boxWidth")) {
            f.width(P)
        } else {
            f.width(Number(I.attr("boxWidth")))
        }
        var O = 0;
        if (I.attr("boxHeight")) {
            O = Number(I.attr("boxHeight"))
        }
        if (O != 0) {
            f.height(O);
            if (I.attr("openDirection") == "top") {
                f.css({
                    top: -O
                })
            } else {
                if (I.attr("openDirection") == "bottom") {
                    f.css({
                        top: 24
                    })
                } else {
                    if (e < O) {
                        if (I.offset().top > O) {
                            f.css({
                                top: -O
                            })
                        } else {
                            if (e < 100 && I.offset().top > e && I.offset().top > 100) {
                                f.css({
                                    top: -O
                                })
                            } else {
                                f.css({
                                    top: 24
                                })
                            }
                        }
                    } else {
                        f.css({
                            top: 24
                        })
                    }
                }
            }
        } else {
            if (I.attr("openDirection") == "top") {
                if (I.offset().top > f.height()) {
                    f.css({
                        top: -f.height()
                    })
                } else {
                    f.height($mainCon.offset().top);
                    f.css({
                        top: -$mainCon.offset().top
                    })
                }
            } else {
                if (I.attr("openDirection") == "bottom") {
                    if (e < f.height()) {
                        f.css({
                            top: 24
                        });
                        f.height(e)
                    } else {
                        f.css({
                            top: 24
                        })
                    }
                } else {
                    if (e < f.height()) {
                        if (I.offset().top > f.height()) {
                            f.css({
                                top: -f.height()
                            })
                        } else {
                            if (e < 100 && I.offset().top > e && I.offset().top > 100) {
                                f.height(I.offset().top);
                                f.css({
                                    top: -I.offset().top
                                })
                            } else {
                                f.css({
                                    top: 24
                                });
                                f.height(e)
                            }
                        }
                    } else {
                        f.css({
                            top: 24
                        })
                    }
                }
            }
        }
        if (!I.attr("boxWidth")) {
            if (f.width() < m + 24) {
                f.width(m + 24)
            }
        }
    }
    function i() {
        var e = $("<div></div>");
        e.addClass("mainCon");
        return e
    }
    function t(e) {
        var N = $("<div></div>");
        N.attr("id", "selectTree" + selectTree_id + "_container");
        N.addClass(e.containerClass);
        N.attr("hasfocus", 0);
        return N
    }
    function G(N) {
        var e = document.createElement("input");
        var P = $(e);
        P.attr("id", "selectTree" + selectTree_id + "_input");
        P.attr("type", "text");
        P.addClass(N.inputClass);
        P.attr("autocomplete", "off");
        var O = false;
        if (I.attr("editable") != null) {
            if (I.attr("editable") == "true") {
                O = true
            } else {
                O = false
            }
        }
        if (!O) {
            P.attr("readonly", "readonly")
        } else {
            P.attr("readonly", false)
        }
        if (I.attr("disabled") == "disabled" || I.attr("disabled") == "true" || I.attr("disabled") == true) {
            P.attr("disabled", true);
            P.addClass("inputDisabled")
        }
        return P
    }
    function D(N) {
        var e = document.createElement("input");
        var O = $(e);
        O.attr("type", "hidden");
        if (I.attr("name") != null) {
            O.attr("name", I.attr("name"))
        }
        return O
    }
    function j(N, e) {
        I.attr("relText", N);
        I.attr("relValue", e);
        p.val(e);
        v.val(N);
        if (q == "true" || q == true) {
            I.attr("editValue", v.val());
            p.val(v.val())
        }
        I.focus();
        return true
    }
    function B(N) {
        if (!N) {
            return
        }
        if (a == true) {
            if (C == "") {
                v.val(g);
                I.attr("relText", g);
                I.attr("relValue", "");
                p.val("")
            } else {
                var V = C.split(",");
                var Q = "";
                for (var S = 0; S < V.length; S++) {
                    for (var R = 0; R < N[z].length; R++) {
                        if (N[z][R].id.toString() == V[S]) {
                            N[z][R].checked = true;
                            Q = Q + N[z][R].name + ",";
                            continue
                        }
                    }
                }
                if (Q.length > 0) {
                    Q = Q.substring(0, Q.length - 1)
                }
                j(Q, C);
                v.attr("title", Q);
                try {
                    enableTooltips()
                } catch (U) {}
            }
            if (I.attr("noGroup") == "true" || I.attr("noGroup") == true) {
                if (H) {
                    $.fn.zTree.init(c, H, N[z])
                } else {
                    $.fn.zTree.init(c, multiNoGroupSelectionSetting, N[z])
                }
            } else {
                if (I.attr("allSelectable") == "true" || I.attr("allSelectable") == true) {
                    if (H) {
                        $.fn.zTree.init(c, H, N[z])
                    } else {
                        $.fn.zTree.init(c, multiTreeSelectionSetting2, N[z])
                    }
                } else {
                    if (H) {
                        $.fn.zTree.init(c, H, N[z])
                    } else {
                        $.fn.zTree.init(c, multiTreeSelectionSetting, N[z])
                    }
                }
            }
        } else {
            if (H) {
                $.fn.zTree.init(c, H, N[z])
            } else {
                $.fn.zTree.init(c, sigleSelectionSetting, N[z])
            }
            if (C == "") {
                v.val(g);
                I.attr("relText", g);
                I.attr("relValue", "");
                p.val("")
            } else {
                I.attr("relValue", C);
                p.val(C);
                var O = $.fn.zTree.getZTreeObj(c.attr("id"));
                var P = O.transformToArray(O.getNodes());
                for (var T = 0; T < P.length; T++) {
                    if (P[T].id.toString() == C) {
                        O.selectNode(P[T]);
                        I.attr("relText", P[T].name);
                        v.val(P[T].name)
                    }
                }
            }
        }
        if (q == true) {
            if (C == "") {
                I.attr("editValue", g)
            } else {
                I.attr("editValue", I.attr("relText"))
            }
        }
    }
    function b() {
        f.attr("hasfocus", 0);
        f.hide();
        $("body").unbind("mousedown", J);
        if (a == true) {
            var O = $.fn.zTree.getZTreeObj(c.attr("id"));
            if (O) {
                var N = O.getCheckedNodes(true);
                var R = "";
                var Q = "";
                for (var P = 0; P < N.length; P++) {
                    if (I.attr("exceptParent") == "true" || I.attr("exceptParent") == true) {
                        if (N[P].isParent) {
                            continue
                        }
                    }
                    R = R + N[P].name + ",";
                    Q = Q + N[P].id + ","
                }
                if (R.length > 0) {
                    R = R.substring(0, R.length - 1)
                }
                if (Q.length > 0) {
                    Q = Q.substring(0, Q.length - 1)
                }
                if (R == "") {
                    R = g
                }
                j(R, Q);
                if (R == g) {
                    v.attr("title", " ")
                } else {
                    v.attr("title", R)
                }
                try {
                    enableTooltips()
                } catch (S) {}
            }
        }
        try {
            I.trigger("change")
        } catch (S) {}
    }
    function r() {
        f.attr("hasfocus", 1);
        depth++;
        I.css({
            zIndex: depth
        });
        f.show();
        $("body").bind("mousedown", J)
    }
    function J(e) {
        if (f.attr("hasfocus") == 0) {} else {
            if ($(e.target).attr("id") == k || $(e.target).attr("id") == w || $(e.target).parent().attr("class") == "ztree" || $(e.target).attr("class") == "ztree" || $(e.target).parents(".ztree").length > 0 || $(e.target).attr("class") == "selectbox-tree") {
                if ($(e.target).parents(".ztree").length > 0) {
                    setTimeout(function () {
                        y()
                    }, 500)
                }
            } else {
                b()
            }
        }
    }
    function h() {
        return I.val()
    }
    function M() {
        return v.val()
    }
};

function getPosition(b, c) {
    for (var a = 0; a < c.length; a++) {
        if (b == c[a]) {
            return a;
            break
        }
    }
}
String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "")
};

function zTreeSelectItemClick(b, d, i) {
    var c = $("#" + d).parents(".selectTree");
    var a = $("#" + d).parents(".mainCon").find('input[type="hidden"]');
    var h = $.fn.zTree.getZTreeObj(d);
    if (c.attr("multiMode") == "true" || c.attr("multiMode") == true) {
        if (i.clickExpand == true || i.clickExpand == "true") {
            if (c.attr("allSelectable") == "true" || c.attr("allSelectable") == true) {
                h.checkNode(i, "", true);
                h.expandNode(i, true)
            } else {
                h.expandNode(i)
            }
        } else {
            h.checkNode(i)
        }
    } else {
        if (i.clickExpand == true || i.clickExpand == "true") {
            h.expandNode(i)
        } else {
            var g;
            g = $("#" + d).parents(".mainCon").find("input[class*=selectbox]");
            g.val(i.name);
            c.attr("relText", i.name);
            c.attr("relValue", i.id);
            a.val(i.id);
            if (c.attr("editable") == "true" || c.attr("editable") == true) {
                c.attr("editValue", g.val());
                a.val(g.val())
            }
            c.focus();
            var j = $("#" + d).parents(".mainCon").find("div[class=selectbox-tree]");
            j.hide();
            j.attr("hasfocus", 0);
            try {
                c.trigger("change")
            } catch (f) {}
        }
    }
}
function zTreeSelectAddItem(e, c, g, d) {
    var b = $.fn.zTree.getZTreeObj(e.find("ul").eq(0).attr("id"));
    var a = b.transformToArray(b.getNodes());
    for (var f = 0; f < a.length; f++) {
        if (a[f].id == c) {
            b.addNodes(a[f], {
                id: g,
                pId: a[f].id,
                name: d
            })
        }
    }
}
function zTreeSelectRemoveItem(c, e) {
    var b = $.fn.zTree.getZTreeObj(c.find("ul").eq(0).attr("id"));
    var a = b.transformToArray(b.getNodes());
    for (var d = 0; d < a.length; d++) {
        if (a[d].id == e) {
            b.removeNode(a[d])
        }
    }
};