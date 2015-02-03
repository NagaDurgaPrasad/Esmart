
$(document).ready(function(){
	$(".container").hide();
	$("#content1").slideDown();
		$("#tab1").css({"background-color":"white","color":"black"});
	$("#tab1").click(function () {
		$(".tab").css({"background-color":"#085592","color":"white"});
		$("#tab1").css({"background-color":"white","color":"black"});
		$(".container").hide();
		$("#content1").toggle();
	});
	$("#tab2").click(function () {
		$(".tab").css({"background-color":"#085592","color":"white"});
		$("#tab2").css({"background-color":"white","color":"black"});
			$(".container").hide();
		$("#content2").toggle();
	});
	$("#tab3").click(function () {
			$(".tab").css({"background-color":"#085592","color":"white"});
		$("#tab3").css({"background-color":"white","color":"black"});
			$(".container").hide();
		$("#content3").toggle();
	});
	$("#tab4").click(function () {
			$(".tab").css({"background-color":"#085592","color":"white"});
		$("#tab4").css({"background-color":"white","color":"black"});
			$(".container").hide();
		$("#content4").toggle();
	});
	$("#tab5").click(function () {
			$(".tab").css({"background-color":"#085592","color":"white"});
		$("#tab5").css({"background-color":"white","color":"black"});
			$(".container").hide();
		$("#content5").toggle();
	});
});

