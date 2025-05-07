const isTouch = "ontouchstart"in window || window.DocumentTouch && document instanceof window.DocumentTouch;
const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) || isTouch;
const $document = $(document);
const $window = $(window);
const $html = $('html');
const $body = $('body');
const $wrap = $('#wrap');
let dur = 200;
let scrollY = 0;
let sldSpeed = 800;
let sldDelay = 2500;
let lenis;

$(function() {
	smoothScroll();
	commonInit();
	swipeEvent();
	gnbUI();
	dropDown();
	sliders();
	tabsEvent();
	accordionEvent();
	modal();
});

// breakpoint
const matchMax = (num) => {
	const match = window.matchMedia('(max-width:' + num + 'px)');
	return match;
};

const matchMin = (num) => {
	const match = window.matchMedia('(min-width:' + num + 'px)');
	return match;
};

// 포커스 이동
const keyFocus = () => { 37.40519, 126.9484
	$document.on('keydown', '[data-focus-prev], [data-focus-next]', (e) => {
		let next = $(e.currentTarget).attr('data-focus-next');
		let prev = $(e.currentTarget).attr('data-focus-prev');
		let target = next || prev || false;

		if(!target || e.keyCode != 9) return;

		if( (!e.shiftKey && !!next) || (e.shiftKey && !!prev) ) {
			$('[data-focus="' + target + '"]').focus();
		}  
	});
}   

// aria 설정
const toggleAria = (item, state) => {
	const $item = $(item)[0].matches('.gnb_li') ? $(item).find('.gnb_link') : item;

	state ? $item.attr('aria-expanded', true) : $item.attr('aria-expanded', false);
}

// dim on/off
const dimToggle = (state) => {
	if (state) {
		if ($('.dim').length > 0) return;
		$body.append('<div class="dim"></div>');

		if ($body.hasClass('allOpen')) { // 전체메뉴 클릭시
			$('.dim').css('z-index', '500');
		}
		
		noscroll(false);
		
		$('.dim').fadeIn(dur);
	} else {
		$('.dim').fadeOut(dur);

		setTimeout(function() {
			$('.dim').remove();
			noscroll(true);
		}, dur);
	}
}

const scrollTarget = (target) => {
	if (lenis) {
		lenis.scrollTo(target);
	} else {
		const offsetTop = $(target).offset().top;
		$('html, body').animate({
			scrollTop: offsetTop
		}, 500);
	}
};

const noscroll = (state) => {
	if (lenis) {
		state ? lenis.start() : lenis.stop();
	} else {
		$html.toggleClass('noscroll', !state);
	}
}

// get praameter
const getParams = (param) => {
	const urlParams = new URLSearchParams(window.location.search);
	return urlParams.get(param);
}

// fetch data
const fetchData = (json) => {
	return fetch(json)
		.then(res => res.json())
		.catch(err => console.error('Error fetching data:', err));
}

const loaderClose = () => {
	if ($('.loading').length === 0) return;

	$('.loading').fadeOut(dur);

	setTimeout(() => {
		$('.loading').remove();
	}, dur);
}

function smoothScroll() {
	if (isMobile) return;
	
	lenis = new Lenis({
		lerp: 0.1,
		easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
	});

	const scrollFn = (time) => {
		lenis.raf(time);
		requestAnimationFrame(scrollFn);
	};

	requestAnimationFrame(scrollFn);
};

// header fixed
function headerFixed() {
	const $header = $('#header');

	const scrollHandler = () => {
		if (scrollY > 50) {
			$header.addClass('fixed');
		} else {
			$header.removeClass('fixed');
		}
	};

	$window.on('scroll', () => {
		scrollHandler();
	}).trigger('scroll');
}

/* common */
function commonInit() {
	if (isMobile) {
		$html.addClass('is-mobile')
	}

	// 첫 로드시 transition 방지
	const transitionAfterPageLoad = () => {
		setTimeout(() => {
			$('.preload').removeClass('preload');
		}, 100);
	};

	// 브라우저 크기 계산
	const setScreenSize = () => {
		let barWh; // scrollbar width

		setTimeout(() => {
			barWh = window.innerWidth - document.body.clientWidth; // scrollbar width
			$html.attr('style', `--scrollbar: ${barWh}px;`);
		}, 300);
	};

	// click event
	$document.on('click', 'a, button', function(e) {
		const href = $(this).attr('href');
		const type = $(this).attr('type');

		if (href === '#' || type === 'submit') {
			e.preventDefault();
			return false;
		}
	});

	$document.on('click', 'a[href*="#"]:not([href="#"])', function(e) {
		if ($(this).attr('href').charAt(0) === '#') {
			e.preventDefault();

			const target = this.hash;
			scrollTarget(target);
		}
	});

	// scroll detector
	$document.on('scrollUp', () => {
		$body.removeClass('down').addClass('up');;
	});

	$document.on('scrollDown', () => {
		$body.removeClass('up').addClass('down');
	}); 

	function gotoTop() {
		const $btn = $('.gotoTop');
		const $footer = $('#footer');
		let footerOffset = 0;

		if ($footer.length > 0) {
			footerOffset = $footer.offset().top;
		}

		if (scrollY > $window.innerHeight() * 0.6) {
			$btn.addClass('on');
		} else {
			$btn.removeClass('on');
		}

		if (scrollY > footerOffset - $window.innerHeight()) {
			$btn.addClass('fixed');
		} else {
			$btn.removeClass('fixed');
		}
	}

	// scroll animation
	function scrollAnim() {
		var anims = [...document.querySelectorAll('[data-anim], [data-anim-txt')];
		var height = $window.innerHeight();
		var point = height * 0.8;

		if (anims.length === 0) return;

		function observerFun(item) {
			var pos = $(item).offset().top;
			var dataOffset = $(item).data('anim-offset');
			var $offset = dataOffset ? dataOffset : 0;

			if (pos < scrollY + point + $offset) {
				$(item).addClass('on');
			} else if (pos > scrollY + height) {
				if (!$(item).hasClass('once')) {
					$(item).removeClass('on');
				}
			}
		}

		anims.forEach(anim => {
			observerFun(anim);
		});
	}

	$window.on('scroll', () => {
		scrollY = $window.scrollTop();
		scrollAnim();
	}).trigger('scroll'); 

	$window.on('scroll resize', () => {
		gotoTop();
	}).trigger('resize'); 

	transitionAfterPageLoad();
	setScreenSize();
	
}

function swipeEvent() {
	// 가로 swipping
	function swipping() {
		const $swipearea = $('.swipearea');

		if ($swipearea.length === 0) return;

		$swipearea.each(function(_, item) {
			const $inner = $(item).find('.inner');
			const $swipeWrap =  $(item).parents('.tblSwipe');
			let isScroll = false;
			let mouseOn = false;
			let widthVal = $inner.find('table').length > 0 ? $inner.find('table').width() - 1 : $inner.width();

			if (isMobile) return;
			if ($(item).width() < widthVal) {

				$(item).kinetic('attach').css({'cursor':'e-resize'});
				isScroll = true;
			} else {
				$(item).kinetic('detach');
				isScroll = false;
			}

			$(item).on('mousedown', function() {
				if ($swipeWrap.length === 0 || !isScroll) return;
				mouseOn = true;
			});

			$(item).on('mousemove', function() {
				if (mouseOn) {
					$swipeWrap.addClass('touched');
				}
			});

			$(item).on('mouseup mouseleave', () => {
				$swipeWrap.removeClass('touched');
				mouseOn = false;
			});
		});
	}

// swiping table
function swipeArea() {
	const $swipes = $('.tblSwipe');

	$swipes.each((_, swipe) => {
		const $fixedTbl = $(swipe).find('.fixed table');
		const $fixedTr = $fixedTbl.find('tr');
		const $swipeTbl = $(swipe).find('.swipearea table');
		const $swipeTr =  $swipeTbl.find('tr');
		let isScroll = false;

		if ($(swipe).find('.swipearea').width() < $swipeTbl.width() - 1) {
			isScroll = true;
		} else {
			isScroll = false
		}

		// 터치 이벤트
		$swipeTbl.on('touchdown touchmove', () => {
			if (!isScroll) return;
			$(swipe).addClass('touched');
		});

		$swipeTbl.on('touchend', () => {
			if (!$(swipe).hasClass('touched')) return;
			$(swipe).removeClass('touched');
		});

			// 높이 계산
			// $fixedTr.each((idx, item) => {
			// 	const $matchTr = $swipeTr.eq(idx);

			// 	if ($(item).height() === $matchTr.height() || $matchTr.length === 0) return;

			// 	$(item).height() > $matchTr.height() 
			// 		? $matchTr.css('height', $(item).height()) 
			// 		: $(item).css('height', $matchTr.height()) 
			// });
		});
	}

	setTimeout(() => {
		swipping();
		swipeArea();
	}, 300);

	
	$window.on('resize', () => {
		swipping();
		swipeArea();
	}); 
}

/* gnb */
function gnbUI() {
	const $header = $('#header');
	const $navigation = $('#navigation');
	const $naviInner = $navigation.find('.inner');
	const $gnbLi = $('.gnb_li');
	//const $subList = $('.sub_link');
	const $openAll = $('.openAllMenu');
	const $allMenu = $('#allMenu');
	const $openNav = $('.openNav');
	const $closeNav = $('.closeNav');
	let index = null;
	let allOpen = false;
	let navOpen = false;

	$gnbLi.each((_, item) => {
		if ($(item).hasClass('hasSub')) {
			$(item).hasClass('on') ? toggleAria(item, true) : toggleAria(item, false);
		}
	});

	// ESC
	$(document).on('keydown', (e) => { 
		if (e.keyCode !== 27) return;

		if (allOpen) {
			allOpen = false;
			toggleAllMenu(allOpen);
		}
	});

	// 초기화
	const gnbReset = (e) => {
		if (e.currentTarget.matches) { // pc
			if (navOpen) {
				navOpen = false;
				toggleNavi(navOpen);
			}

			index = null;
			menuHandler();
			$gnbLi.off('.moHandle');
			$openNav.off('.moHandle');
			$closeNav.off('.moHandle');
			$navigation.off('.moHandle');
			$naviInner.off('.moHandle');

			$gnbLi.on('mouseenter.pcHandle focusin.pcHandle mouseleave.pcHandle focusout.pcHandle click.pcHandle', pcGnbHandler);
			//$subList.on('click.pcHandle', pcGnbHandler);
			$header.on('mouseenter.pcHandle', pcHeaderHandler);
			$header.on('mouseleave.pcHandle', pcHeaderHandler);
			$openAll.on('click.pcHandle', allMenuHandler);
		} else { // mobile
			
			if (allOpen) {
				allOpen = false;
				toggleAllMenu(allOpen);
			}
		
			index = null;
			menuHandler();
			$gnbLi.off('.pcHandle');
			$header.off('.pcHandle');
			$openAll.off('.pcHandle');
			
			$gnbLi.on('click.moHandle', moGnbHandler);
			$openNav.on('click.moHandle', naviHandler);
			$closeNav.on('click.moHandle', naviHandler);
			$navigation.on('click.moHandle', naviHandler);
			$naviInner.on('click.moHandle', (e) => { e.stopPropagation() });
		}
	};

	$(matchMin(1025)).on('change', gnbReset).change();

	// pc header 
	function pcHeaderHandler(e) {
		const type = e.handleObj.origType;
		
		if (type === 'mouseenter') {
			$body.addClass('gnbOn');
		} else if (type === 'mouseleave') {
			$body.removeClass('gnbOn');
		}
	}

	// allmenu 
	function allMenuHandler() {
		allOpen = !allOpen;
		toggleAllMenu(allOpen);
	}

	function toggleAllMenu(state) {
		$openAll.toggleClass('open', state);
		$body.toggleClass('allOpen', state);
		toggleAria($openAll, state);

		if (state) {
			$openAll.attr('aria-label', '전체 메뉴 닫기');
			$allMenu.stop().slideDown(dur);
			$openAll.prev('a').attr({ 'data-focus': 'allMenu' });
			$allMenu.find('a').last().attr({ 'data-focus-next': 'allMenu' });
			dimToggle(true);
			keyFocus();
		} else {
			$openAll.attr('aria-label', '전체 메뉴 열기').focus();
			$allMenu.stop().slideUp(dur);
			$openAll.prev('a').removeAttr('data-focus');
			$allMenu.find('a').last().removeAttr('data-focus-next');
			dimToggle(false);
		}
	};

	// navigation 
	function naviHandler(e) {
		const target = e.currentTarget;
		let sate = $(target).hasClass('openNav') ? true :  false;
		
		navOpen = sate;
		toggleNavi(navOpen);
	}

	function toggleNavi(state) {
		$navigation.toggleClass('open', state);
		$body.toggleClass('navOn', state);

		if (state) {
			$navigation.css('visibility', 'visible').attr({ 'tabindex': 0, 'data-focus': 'navi' });
			$navigation.find('a').last().attr({ 'data-focus-next': 'navi' });
			keyFocus();
			noscroll(false);
		} else {
			$openNav.focus();
			$navigation.removeAttr('tabindex data-focus');
			$navigation.find('a').last().removeAttr('data-focus-next');

			setTimeout(() => {
				$navigation.removeAttr('style');
				noscroll(true);
			}, dur);
		}
	};

	// pc gnb
	function pcGnbHandler(e) {
		const type = e.handleObj.origType;
		const target = e.currentTarget;

		//e.stopPropagation();

		if (allOpen) return;
		
		// on
		if (type === 'mouseenter') { 
			index = $(target).index();
		} 

		if (type === 'focusin') {
			index = $(e.target).parents('.gnb_li').index();
		}

		// out
		if (type === 'mouseleave' || type === 'focusout') {
			index = null;
		}

		if (e.target.matches('.sub_link, .gnb_sub') && type !== 'mouseleave'
			|| (e.target.matches('.gnb_link') && type === 'click')
		) return;
		menuHandler();
	}

	// mobile gnb 
	function moGnbHandler(e) {
		const type = e.handleObj.origType;
		const target = e.currentTarget;

		if (!$(target).hasClass('hasSub') || e.target.matches('.sub_link')) return;
		e.preventDefault();
		
		index = $(target).index();
		menuHandler();
	}

	// toggle gnb
	function menuHandler() {
		$gnbLi.each((i, item) => {
			let state = index === i;

			if (state) {
				$(item).hasClass('on') ? toggleMenu(item, false) : toggleMenu(item, true);
			} else {
				toggleMenu(item, false);
			}
		});

		function toggleMenu(main, state) {
			const $subMenu = $(main).find('.gnb_sub');
			$(main).toggleClass('on', state);
			state ? $subMenu.stop().slideDown(dur) : $subMenu.stop().slideUp(dur);
			toggleAria(main, state);
		}
	}
}

// header utils svg
function headerUtils() {
	const data = {
		login: {icon: `<path d="M21.8 5.9c-1.7-2.3-4.1-3.9-7-4.4-2.8-.5-5.6.2-7.9 1.8C5.9 4 5 4.9 4.3 5.9c-.3.3-.2.8.2 1.1.3.2.8.2 1-.2.6-.9 1.4-1.6 2.2-2.2 2-1.4 4.5-2 6.9-1.6 2.4.4 4.6 1.8 6 3.8 1.4 2 2 4.5 1.6 6.9s-1.8 4.6-3.8 6c-2 1.4-4.5 2-6.9 1.6-2.4-.4-4.6-1.8-6-3.8-.2-.3-.7-.4-1-.2-.3.2-.4.7-.2 1 1.7 2.3 4.1 3.9 7 4.4.6.1 1.2.2 1.8.2 2.2 0 4.3-.7 6.2-2 2.3-1.7 3.9-4.1 4.4-7 .4-2.8-.2-5.7-1.9-8z" /><path d="M11.1 14.7c-.3.3-.3.8 0 1.1.1.1.3.2.5.2s.4-.1.5-.2l2.8-3c.3-.3.3-.7 0-1l-2.8-3c-.3-.3-.8-.3-1.1 0-.3.3-.3.8 0 1.1l1.6 1.7H1.5c-.4 0-.8.3-.8.8s.3.8.8.8h11.3l-1.7 1.5z" /><`},
		logout: {icon: `<path d="M21.8 5.9c-1.7-2.3-4.1-3.9-7-4.4-2.8-.5-5.6.2-7.9 1.8C5.8 4 5 4.9 4.3 5.9c-.3.3-.2.8.2 1.1.3.2.8.2 1-.2.6-.9 1.4-1.6 2.2-2.2 2-1.4 4.5-2 6.9-1.6 2.4.4 4.6 1.8 6 3.8s2 4.5 1.6 6.9c-.4 2.4-1.8 4.6-3.8 6-4.2 2.9-9.9 2-12.9-2.2-.2-.3-.7-.4-1-.2-.3.2-.4.7-.2 1 2.1 3 5.4 4.5 8.8 4.5 2.1 0 4.3-.6 6.2-2 2.3-1.7 3.9-4.1 4.4-7 .4-2.7-.2-5.6-1.9-7.9z" /><path d="M4.8 15.7c.3-.3.3-.8 0-1.1L3.2 13h11.3c.4 0 .8-.3.8-.8s-.3-.8-.8-.8H3.2l1.6-1.7c.3-.3.3-.8 0-1.1-.3-.3-.8-.3-1.1 0l-2.8 3c-.3.3-.3.7 0 1l2.8 3c.2.3.4.4.6.4.2 0 .4-.1.5-.3z" />`},
		mypage: {icon: `<path d="M19.8 23.4H2.5c-.7 0-1.3-.6-1.3-1.3v-1.4c0-3.5 2.4-6.7 6.1-8.2-1.3-1.2-2-2.9-2-4.7 0-3.6 3-6.6 6.6-6.6 3.6 0 6.6 3 6.6 6.6 0 1.8-.7 3.5-2 4.7 3.7 1.5 6.1 4.6 6.1 8.2 0 .4-.3.8-.8.8s-.8-.3-.8-.8c0-3.2-2.6-6.2-6.4-7.2-.3-.1-.5-.3-.5-.6s.1-.6.4-.7c1.5-.9 2.4-2.5 2.4-4.3 0-2.8-2.3-5.1-5.1-5.1-2.6 0-4.9 2.2-4.9 5 0 1.8.9 3.4 2.4 4.3.3.2.4.5.3.7s-.3.5-.5.6c-3.8 1-6.4 4-6.4 7.2v1.2h17c.4 0 .8.3.8.8s-.3.8-.7.8z" />`},
		ticket: {icon: `<path d="M23.1 14.2c.4 0 .8-.3.8-.8V6.8c0-1.8-1.5-3.3-3.3-3.3H3.5C1.7 3.5.2 5 .2 6.8v10.4c0 1.8 1.5 3.3 3.3 3.3h17.1c1.8 0 3.3-1.5 3.3-3.3 0-.4-.3-.8-.8-.8s-.8.3-.8.8c0 1-.8 1.8-1.8 1.8h-17c-1 0-1.8-.8-1.8-1.8V6.8c0-1 .8-1.8 1.8-1.8h17.1c1 0 1.8.8 1.8 1.8v6.7c0 .4.3.7.7.7z"/><path d="M8 13.6c0-.6-.4-1-1-1s-1 .5-1 1 .4 1 1 1 1-.4 1-1zm0-3.2c0-.6-.4-1-1-1s-1 .4-1 1v.1c0 .6.4 1 1 1s1-.4 1-1.1c0 .1 0 0 0 0zm-1 5.2c-.6 0-1 .5-1 1s.4 1 1 1 1-.4 1-1v-.1c0-.5-.4-.9-1-.9zm1-8.3c0-.6-.4-1-1-1s-1 .4-1 1v.1c0 .6.4 1 1 1s1-.3 1-1.1z"/><defs><filter id="a" width="9" height="8.6" x="10.5" y="7.7" filterUnits="userSpaceOnUse"><feColorMatrix values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0"/></filter></defs><mask id="b" width="9" height="8.6" x="10.5" y="7.7" maskUnits="userSpaceOnUse"><path d="m15 14.3-1.9 1c-.2.1-.4-.1-.3-.2l.4-2.1-1.6-1.5c-.1-.1-.1-.4.1-.4l2.1-.3 1-1.9c.1-.2.3-.2.4 0l1 1.9 2.1.3c.2 0 .3.3.1.4L16.8 13l.4 2.1c0 .2-.2.3-.3.2l-1.9-1z" style="fill:#fff;filter:url(#a)"/></mask><path d="m15 14.3-1.9 1c-.2.1-.4-.1-.3-.2l.4-2.1-1.6-1.5c-.1-.1-.1-.4.1-.4l2.1-.3 1-1.9c.1-.2.3-.2.4 0l1 1.9 2.1.3c.2 0 .3.3.1.4L16.8 13l.4 2.1c0 .2-.2.3-.3.2l-1.9-1z" style="mask:url(#b);fill:currentColor;stroke:currentColor;stroke-width:2"/>`},
		menu: {icon: `<path d="M1 4h13c.6 0 1-.4 1-1s-.4-1-1-1H1c-.6 0-1 .4-1 1s.4 1 1 1zM23 11H1c-.6 0-1 .4-1 1s.4 1 1 1h22c.6 0 1-.4 1-1s-.4-1-1-1zM18 20H1c-.6 0-1 .4-1 1s.4 1 1 1h17c.6 0 1-.4 1-1s-.4-1-1-1z" />`},
	}

	const items = $('[data-svg]');

	items.each((_, item) => {
		const key = $(item).data('svg');
		const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">${data[key].icon}</svg>`;
		$(item).append(svg);
	});

}

/* dropDown */
function dropDown() {
	const $dropdowns = $('.dropdown');

	$dropdowns.each((_, item) => {
		if ($(item).hasClass('open')) {
			$(item).data('isOpen', true);
			toggleContent(item, true);
		}
	});


	$document.on('click', '.dropdown .drop_btn', (e) => {
		const $target = $(e.target);
		const $dropdown = $target.parents('.dropdown');
		let isOpen = $dropdown.data('isOpen') || false;

		isOpen = !isOpen;

		toggleContent($dropdown, isOpen);
		$dropdown.data('isOpen', isOpen);
		e.preventDefault();
	});

	function toggleContent(dropdown, state) {
		const $btn = $(dropdown).find('.drop_btn');
		const $content = $(dropdown).find('.drop_content');
		$(dropdown).toggleClass('open', state);
		toggleAria($btn, state);

		state ? $content.stop().slideDown(dur) : $content.stop().slideUp(dur);
	}
}

function sliders() {
		// common slider
		const $sliders = $('.slider');
		sldSpeed = 600;
	
		if ($sliders.length === 0) return;

		const initSwiper = (el) => {
			const $slider = $(el);
			const $next = $slider.find('.swiper-button-next'); 
			const $prev = $slider.find('.swiper-button-prev');
			const $page = $slider.find('.swiper-pagination');
			const view = $slider.data('view');
			const space = $slider.data('space');
			const delay = $slider.data('delay');
			const pageType = $slider.data('pagetype');
			let options = {}
			let swiper;

			// default option
			const defaultOption = {
				loop: $slider.hasClass('loop') ? true : false,
				autoplay: !$slider.hasClass('auto') ? false : {
					delay: delay ? delay : sldDelay,
				},
				observer: true,
				observeParents: true,
				navigation: {
					nextEl:  $next[0],
					prevEl: $prev[0],
				},
				pagination: {
					el: $page[0],
					clickable: true,
					type: pageType ? pageType : 'bullets',
				},
			}
			
			// basic option
			const options1 = {
				speed: 400,
				slidesPerView: view ? 'auto' : 1,
				slidesPerGroup: 1,
				spaceBetween: space ? 0 : 0,
				freeMode: view ? true : false,
				...defaultOption,
				breakpoints: {
					992: {
						speed: 400,
						slidesPerView: view ? 'auto' : 1,
						slidesPerGroup: 1,
						spaceBetween: space ? 0 : 0,
						freeMode: view ? true : false,
					},
					1025: {
						speed: sldSpeed,
						slidesPerGroup: $slider.hasClass('group') ? view[1] : 1,
						slidesPerView: view ? view[1] : 1,
						spaceBetween: space ? space[1] : 0,
						freeMode: false,
					},
					1401: {
						speed: sldSpeed,
						slidesPerGroup: $slider.hasClass('group') ? view[0] : 1,
						slidesPerView: view ? view[0] : 1,
						spaceBetween: space ? space[0] : 0,
						freeMode: false,
					},
				}
			}

			// type2 option
			const options2 = {
				speed: 400,
				slidesPerGroup: $slider.hasClass('group') ? view[3] : 1,
				slidesPerView: view ? 'auto' : 1,
				slidesPerView: view ? view[3] : 1,
				spaceBetween: space ? space[3] : 0,
				...defaultOption,
				breakpoints: {
					768: {
						speed: 400,
						slidesPerGroup: $slider.hasClass('group') ? view[2] : 1,
						slidesPerView: view ? view[2] : 1,
						spaceBetween: space ? space[2] : 0,
					},
					992: {
						speed: 400,
						slidesPerGroup: $slider.hasClass('group') ? view[1] : 1,
						slidesPerView: view ? view[1] : 1,
						spaceBetween: space ? space[1] : 0,
					},
					1401: {
						speed: sldSpeed,
						slidesPerGroup: $slider.hasClass('group') ? view[0] : 1,
						slidesPerView: view ? view[0] : 1,
						spaceBetween: space ? space[0] : 0,
					},
				}
			}

			// type3 option
			const options3 = {
				speed: 400,
				slidesPerView: "auto",
				freeMode: true,
				...defaultOption,
			}

			if ($slider.hasClass('type2')) {
				options = {...options2}
			} else if ($slider.hasClass('type3')) {
				options = {...options3}
			} else {
				options = {...options1}
			}
			
			if (!swiper) {
				swiper = new Swiper($slider[0], options);
			}
		}

		$sliders.each((_, slider) => {
			initSwiper(slider);
		});
}


/* tabs */
function tabsEvent() {
	const $tabs = $('.tabs');

	$tabs.each((_, tab) => {
		const $links = $(tab).find('.tab_link');
		const $tabPanels = $(tab).find('.tab_panel');
		let target = null;
		
		// tab 초기화
		$links.each((_, item) => {
			if ($(item).hasClass('active')) {
				target = $(item).attr('aria-controls');
				tabChange();
			}
		});

		// tab 클릭 이벤트
		$links.on('click', function(e) {
			e.preventDefault();

			const $this = this;
			target = $($this).attr('aria-controls');

			tabChange();
		});

		// tab 키보드 이벤트
    $links.on('keydown', function(e) {
			const $this = $(this);
			const $current = $this;
			let $next = null;
			
			switch(e.key) {
					case 'ArrowLeft':
							$next = $current.prev('.tab_link') ? $current.prev('.tab_link') : null;
							break;
					case 'ArrowRight':
							$next = $current.next('.tab_link') ? $current.next('.tab_link') : null;
							break;
					case 'Home':
							$next = $links.first();
							break;
					case 'End':
							$next = $links.last();
							break;
					default:
							return;
			}

			if ($next && $next.length) {
					e.preventDefault();
					$next.focus().click();
			}
	});

		function tabChange() {
			$links.each((_, item) => {
				if ($(item).attr('aria-controls') === target) {
					$(item).addClass('active').attr('aria-selected', 'true').attr('tabindex', '0');
				} else {
					$(item).removeClass('active').attr('aria-selected', 'false').attr('tabindex', '-1');
				}
			});

			$tabPanels.each((_, item) => {
				if ($(item).attr('id') === target) {
					$(item).removeAttr('hidden').attr('tabindex', '0');
				} else {
					$(item).attr('hidden', 'true').attr('tabindex', '-1');
				}
			});
		}
	});
}

/* accordion */
function accordionEvent() {
	const $accordions = $('.accordion');

	$accordions.each((_, accordion) => {
		const $btns = $(accordion).find('.accordion_btn');
		const $items = $(accordion).find('.accordion_item');
		let index = null;

		$btns.each((i, btn) => {
			const $item = $(btn).parents('.accordion_item');
			index = $(btn).hasClass('on') ? $item.index() : null;
			let state = index ===  i;

			toggleContent($(btn), state);
		});

		$btns.on('click', function() {
			const $item = $(this).parents('.accordion_item');

			$(this).toggleClass('on');
			index = $(this).hasClass('on') ? $item.index() : null;

			$items.each((i, item) => {
				const $btn = $(item).find('.accordion_btn');
				let state = index ===  i;

				toggleContent($btn, state);
			});
			
		});
		
		function toggleContent(btn, state) {
			const $item = $(btn).parents('.accordion_item');
			const $cont = $item.find('.accordion_cont');

			toggleAria($(btn), state);

			if (state) {
				$cont.slideDown(dur).addClass('open');

				if ($cont.hasClass('thumb_hover')) {
					setTimeout(() => {
						$cont.addClass('start');
					}, 400);
				}
			} else {
				$cont.slideUp(dur).removeClass('open');
				$(btn).removeClass('on');

				if ($cont.hasClass('start')) {
					$cont.removeClass('start');
				}
			}
		}
	});
}

// modal
function modal() {
	let targetBtn;
	
	if ($('.modal.open').length > 0) {
		openModal();
	}

	$document.on('click', '.openModal', (e) => {
		const $this = e.currentTarget;
		e.preventDefault();

		openModal($this);
		targetBtn = $this;
	});

	$document.on('click', '.closeModal, .dim', (e) => {
		const $this = e.currentTarget;
		e.preventDefault();

		closeModal($this);

		if (targetBtn) {
			targetBtn.focus();
			targetBtn = null;
		}
	});

	// 키보드 esc 닫기
	$document.on('keydown', (e) => { 
		if (!$('.modal.open').length === 0) return;

		if (e.keyCode == 27) { 
			closeModal(e.target);
		}
	});

	function openModal(el) {
		const target = $(el).data('target');

		$(target).attr('tabindex', '0').fadeIn(dur).addClass('open').focus();
		keyFocus();
		dimToggle(true);
	}

	function closeModal(el) {
		const $target = el.className === '.closeModal' ? $(el).parents('.modal') : $('.modal.open');

		if (!$target.hasClass('open')) return;

		$target.attr('tabindex', '-1').fadeOut(dur);
		dimToggle(false);

		setTimeout(() => {
			$target.removeClass('open');
		}, dur);
		
	}
}

function alertPopup(msg) {
	const $popup = $('.alertPopup');
	
	$popup.find('.alert_msg').html(msg);
}