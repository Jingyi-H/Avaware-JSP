<script type="text/javascript">
	$(function(){
		var nav=$("#nav_bar"); //�õ���������
		var win=$(window); //�õ����ڶ���
		var doc=$(document);//�õ�document�ĵ�����
		win.scroll(function(){
		  if(doc.scrollTop()>=40){
			nav.addClass("nav-bar-fixed");
		  }else{
			nav.removeClass("nav-bar-fixed");
		  }
		})
	})
</script>