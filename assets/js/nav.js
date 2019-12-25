<script type="text/javascript">
	$(function(){
		var nav=$("#nav_bar"); //得到导航对象
		var win=$(window); //得到窗口对象
		var doc=$(document);//得到document文档对象。
		win.scroll(function(){
		  if(doc.scrollTop()>=40){
			nav.addClass("nav-bar-fixed");
		  }else{
			nav.removeClass("nav-bar-fixed");
		  }
		})
	})
</script>