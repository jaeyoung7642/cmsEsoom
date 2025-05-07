var $html = $('html');
var $body = $('body');

$(document).ready(function(){
    var $btnToggle = $('.btn_tg'),
        $select = $('.custom_select'),
        $calendar = $('.calendar');


    // toggle button
    $btnToggle.click(function(){
        var $this = $(this),
            action = $this.data('action');

        $this.closest('.tgwrp').find('.btn_tg').toggleClass('on');
        if(action === 'slide'){
            if($this.hasClass('on')){
                $('.btn_tg.on:not(.fix)').not($this.closest('.tgwrp').find('.btn_tg')).removeClass('on')
                    .closest('.tgwrp').find('.tgcon').slideUp(200);
            }
            $this.closest('.tgwrp').find('.tgcon').slideToggle(300);
        }
        return false;
    });

		// click event
		$(document).on('click', 'a, button', function(e) {
			const href = $(this).attr('href');
			const type = $(this).attr('type');

			if (href === '#' || type === 'submit') {
				e.preventDefault();
				return false;
			}
		});

		// modal close
		$(this).on('click', '.modal .close, .dim', function(){
			if ($(this).hasClass('dim')) {
				closeModal($('.modal.on'));
			}
			closeModal($(this).closest('.modal'));
		});

    // custom select
    $select.customSelect();

    // custom scrollbar
    scrollbar('.scrollarea');

    // attach file
    $(this).on('change', '.frm_file input', function(){
        $(this).next('.frmbox').empty().append(this.value);
    });

		// 이미지 파일 업로드
    $(this).on('change', '.uploadImg input', function(){
			if (this.files && this.files[0]) {
				const $root = $(this).parents('.frm_file_thumb');
				let reader = new FileReader();

				reader.onload = function(e) {
					$root.addClass('upload');
					$root.find('.fileThumb').attr('src', e.target.result);
					$root.find('.file_veiw').attr('href', e.target.result);
				}

				reader.readAsDataURL(this.files[0]); 
			}
    });

		// 파일 보기
		$(document).on('click', '.file_veiw', function(e) {
			const $this = $(this);
      const url = $this.attr("href");

			if (url) {
				var html = `
					<html>
						<style>
							html, body {padding: 0; margin: 0;}
							iframe {width: 100%; height: 100%; border: 0;}
						</style>
						<body>
							<iframe type="application/pdf" src="${url}"></iframe>
						</body>
					</html>
				`;

				var a = window.open("about:blank", "Zupfnoter");
				a.document.write(html);
				a.document.close();
		}

			e.preventDefault();
		});

		// 파일 삭제
		$(document).on('click', '.file_delete', function(e) {
			const $root = $(this).parents('.frm_file_thumb');

			$root.removeClass('upload');
			$root.find('.fileThumb').attr('src', '#');
			$root.find('.file_veiw').attr('href', '#');
		});

    // calendar
    $calendar.datepicker({
        dateFormat: 'dd MM yy',
        dayNamesMin: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
        showOtherMonths: true,
        // setDate: 'today'
    }).datepicker('setDate', 'today');;
});

$(window).load(function(){
    // slider
    $('.slider').each(function(){
        var $pager = $(this).next('.pager');

        $(this).lightSlider({
            item: 1,
            slideMargin: 0,
            adaptiveHeight: true,
            pager: false,
            onSliderLoad: function (el) {
                var $parent = el.parents('.lSSlideOuter'),
                    total = el.find('li').length;

                $pager.find('.total').text(el.find('li').length);
                el.next('.lSAction').appendTo($parent);
                if(total > 1) $parent.find('.lSAction').addClass('next');
            },
            onAfterSlide: function (el) {
                var $control = el.parent().next('.lSAction'),
                    total = el.find('li').length,
                    current = el.find('.active').index();

                $pager.find('.current').text(current+1);
                if(current > 0){
                    $control.addClass('prev');
                    if(current === total-1){
                        $control.removeClass('next');
                    } else {
                        $control.addClass('next');
                    }
                } else {
                    $control.removeClass('prev');
                }
            }
        });
    });

		setScreenSize();
		checkAll();
});

$(function() {
	setScreenSize();
	checkAll();
});

// 브라우저 스크롤바 계산
function setScreenSize() {
	let barWh = window.innerWidth - document.body.clientWidth; // scrollbar width

	$html.attr('style', `--scrollbar: ${barWh}px;`);
}

// 체크박스 
function checkAll() {
	var $checkEl = $('.js_check_wrap');

	if ($checkEl.length < 1) { return}

	$($checkEl).each(function(idx, item) {
		var $all = $(item).find('.js_check_all');
		var $checkbox = $(item).find('.js_check_each');
		var boxNum = $($checkbox).length;

		$($all).on('click', function() {
			$(this).prop('checked') ? $($checkbox).prop('checked', true) : $($checkbox).prop('checked', false);
		});

		$($checkbox).on('click', function() {
			var checkedNum = $($checkbox).filter(":checked").length;

			if (boxNum == checkedNum) {
				$($all).prop("checked", true);
			} else {
				$($all).prop("checked", false);
			}
			
		});

	});
	
}

// custom scrollbar
function scrollbar(el){
    $(el).mCustomScrollbar({
        scrollbarPosition: 'outside',
        scrollInertia: 100
    });
}

// dim
function dimOff(){
    $html.find('.dim').removeClass('on').fadeOut(300, function(){
        $(this).remove();
    });
}

// modal
function modal(el){
	$(el).addClass('on').stop().fadeIn(300);
	
	if (!$body.hasClass('noscroll')) {
		$body.addClass('noscroll');
	}
	
	if($html.find('.dim.on').length < 1){
		$('<span class="dim on pop"></span>').appendTo($('#wrap')).stop().fadeIn(300);
	}
}
function closeModal(el){
	$(el).removeClass('on').stop().fadeOut(300);

	if ($body.hasClass('noscroll')) {
		setTimeout(() => {
			$body.removeClass('noscroll');
		}, 300);
		
	}

	if($html.find('.modal.on').length < 1){
			dimOff();
	}
}