$(document).ready(function() {
	/*排序效果*/
	$(".g_1").mouseenter(function() {
		$(this).next(".equi").toggle().parents(".equip").siblings().find(".equi").hide();
	});
	$(".equip").mouseleave(function() {
		$(".equi").hide();
	});
	$(".list").mouseenter(function() {
		$(this).next(".listpal").toggle().parents(".ch").siblings().find(".listpal").hide();
	});
	$(".lp").mouseleave(function() {
		$(".listpal").hide();
	});
	$('.listpal li').click(function() {
		$(this).siblings().find('.active').removeClass();
		$(this).children('img').addClass("active");
	});
	var j = true;
	$('.choose-value').click(function(){
		if(j){
			$('.choose-list').css('display','block');
			j=false;
		}else{
			$('.choose-list').css('display','none');
			j = true;
		}
		
	})
	$('.choose-list li').click(function() {
		$(this).siblings('.choose-checked').removeClass();
		$(this).addClass('choose-checked');		
		$('#datetype').html($(this).text());
	});
	/*全选反选*/
	$(".chk_1").click(function() {
		if(this.checked) {
			$("#pageBodyCenter .table :checkbox").prop("checked", true);
			$("#n1").html("已选中" + $("#pageBodyCenter .table tr").length + "个文件/文件夹");
			$('#g_button').css('display', 'none');
			$('.equip_1').css('display', 'block');
			$('.Qdh').find('li').nextAll('li').hide();
		} else {
			$("#pageBodyCenter .table :checkbox").prop("checked", false);
			$("#n1").html("文件名");
			$('#g_button').css('display', 'block');
			$('.equip_1').css('display', 'none');
			$('.Qdh').find('li').nextAll('li').show();
		}
	});
	$('table').on('click','.chk_2',function() {
		 var num=$('#mytbody input:checked').length;
		 if(num>0&&num<$('#mytbody input:checkbox').length){
			 var msg="已选中"+num+"个文件/文件夹";
			 $('.Qdh').find('span').html(msg);
			 $('#g_button').css('display', 'none');
			 $('.equip_1').css('display', 'block');
			 $('.Qdh').find('li').nextAll('li').hide(); 
		 }else if(num==$('#mytbody input:checkbox').length){
			 $('.chk_1').prop('checked',true);
			 var msg="已选中"+num+"个文件/文件夹";
			 $('#g_button').css('display', 'none');
			 $('.equip_1').css('display', 'block');
			 $('.Qdh').find('span').html(msg);					 					 
		 }else{
			 $('.chk_1').attr('checked',false);
			 $('.Qdh').find('span').html('文件名');
			 $('.equip_1').css('display', 'none');
			 $('#g_button').css('display', 'block');
			 $('.Qdh').find('li').nextAll('li').show();
		 }		
	});

	/*reception界面全选反选*/
	$(".ck1").click(function() {
		if(this.checked) {
			$("#qdh :checkbox").prop("checked", true);
			$("#n1").html("已选中" + $('#qdh input:checkbox').length + "个文件/文件夹");
		} else {
			$("#qdh :checkbox").prop("checked", false);
			$("#n1").html("文件夹");
		}
	});
	$('#qdh').on('click','input:checkbox',function() {
		 var num=$('#qdh input:checked').length;
		 if(num>0&&num<$('#qdh input:checked').length){
			 var msg="已选中"+num+"个文件/文件夹";
			 $('.Qdh').find('#n1').html(msg);
		 }else if(num==$('#qdh input:checked').length){
			 $('.chk_1').prop('checked',true);
			 var msg="已选中"+num+"个文件/文件夹";
			 $('.Qdh').find('#n1').html(msg);					 					 
		 }else{
			 $('.chk_1').attr('checked',false);
			 $('.Qdh').find('#n1').html('文件夹');
		 }		
	});
	
	$("#tabs a").click(function() {
		$(this).tab('show');
	});
	$(".tab a").click(function() {
		$(this).tab('show');
	});

	
			$("#chall").click(function() {
				if(this.checked) {
					$(".timelin_content").find('span').css('display', 'inline-block');
					$("#c1").html("已选中" + $(".timelin_content").children('span').length + "张图片");
					$('.donetimeline').css('display', 'block');
				} else {
					$(".timelin_content").find('span').css('display', 'none');
					$("#c1").html("已选中0张图片");
					$('.donetimeline').css('display', 'none');
				}
			});
			$('.table').on('mouseenter','tr',function() {
				$(this).css('background','rgba(220, 200, 200, 0.4)');
				$(this).children().find('.more').css('display', 'inline-block');
				
			});
			$('.table').on('mouseleave','tr',function() {
				$(this).css('background','none');
				$(this).children().find('.more').css('display', 'none');
			});

		
			
});
