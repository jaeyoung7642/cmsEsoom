const isTouch = 'ontouchstart' in window || (window.DocumentTouch && document instanceof window.DocumentTouch);
const isMobile = /Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) || (navigator.userAgent.includes('iPad') || (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1)) || isTouch;
const nodes = {
	html: $('html'),
	body: $('body'),
}
const dur = 300;
const dur_sld = 200;
let scrollY = 0;
let respCheck = null;

class Common {
	constructor() {
		this.header = $('#header');
		this.init();
	}
	init() {
		// device check
		if (isMobile) {
			nodes.html.addClass('is-mobile');
		}
		
		this.setAttribute();
		this.updateRespCheck(); // responsive check
		this.updateNoTrans();
		this.updateScrollY(); // update scrollY
		this.scrollDirection(); // scroll direction 
		this.headerFixed(); // header fixed
		this.anchorEvent(); // a lnik 
		this.gotoTopButton(); // goto top button
		this.screenZoomIn();
	}
	setAttribute() {
		// scrollbar width;
		let barWidth = window.innerWidth - document.body.clientWidth;
		nodes.html[0].style.setProperty('--scrollbar', `${barWidth}px`);

		// 외부링크
		const exLinkSet = (link) => {
			const $link = $(link);

			if (!$link.attr('rel')?.includes('noreferrer')) {
				$link.attr('rel', 'noreferrer');
			}

			if ($link.parents('.exlink_icon')[0]) { // 아이콘 있을 경우
				const $txtEl = $link.find('.txt');
				const hasBlindText = $link.find('.blind').length > 0;
        const hasIcon = $link.find('c-icon[name="link"]').length > 0;

				if (!hasBlindText) {
					if ($txtEl.length > 0) {
						$txtEl.append(`<span class="blind">(새창열림)</span>`);
					} else {
						const text = $(link).text();
						$(link).html(`<span class="txt">${text}</span> <span class="blind">(새창열림)</span>`);
					}
				}
				if (!hasIcon) {
					$link.append('<c-icon name="link"></c-icon>');
				}
			} else {
				if ($link.find('.blind').length === 0) {
					$(link).append('<span class="blind">(새창열림)</span>');
				}
			}
		}

		const $exLinks = $('a[target="_blank"]');
		$exLinks.each((_, link) => exLinkSet(link));
	}
	updateRespCheck() {
		const breakpoint = (e) => {
			if (e.target.matches) { // pc
				respCheck = 'pc';
			} else { // mobile
				respCheck = 'mobile';
			}
		};

		$(matchMin(1024)).on('change', breakpoint).change();
	}
	updateNoTrans() {
		const $elms = $('[data-notrans]');
    if (!$elms.length) return;

    const applyNoTrans = ($el) => {
        $el.addClass('notrans');
        setTimeout(() => toggleHelper($el, false, 'notrans'), dur);
    };

    const handleResize = ($el, device) => {
        const onBreakpointChange = (e) => applyNoTrans($el);
        $(matchMin(device)).on('change', onBreakpointChange).change();
    };

    $elms.each((_, el) => {
        const $el = $(el);
        const breakpoints = $el.data('notrans') || [1024];
        breakpoints.forEach((bp) => handleResize($el, bp));
    });
	}
	updateScrollY() {
		const updateScroll = debounceRAF(() => {
			const locScrollY = $(window).scrollTop();

			if (locScrollY !== scrollY) scrollY = locScrollY;
		});

		$(window).on('scroll', updateScroll).trigger('scroll');
	}
	scrollDirection() {
		let prevScrollY = $(window).scrollTop();
	
		const updateScroll = debounceRAF(() => {
			const direction = prevScrollY < scrollY ? "down" : "up";
			prevScrollY = scrollY;

			if (nodes.body.attr('data-direction') !== direction) {
				nodes.body.attr('data-direction', direction);
			}
		});

		$(window).on('scroll', updateScroll).trigger('scroll');
	}
	headerFixed() {	
		const $header = $(this.header);
		const rows = $header.find('.header_row:not(.header_main)');

		const updateScroll = debounceRAF(() => {
			const rowsHeight = [...rows].map((row) => $(row).outerHeight());
			const totalHeight = rowsHeight.reduce((sum, height) => sum + height, 0);

			if (scrollY > $header.outerHeight()) {
				$header.addClass('fixed');
			} else if (scrollY <= totalHeight && $header.hasClass('fixed')) {
				$header.removeClass('fixed');
			}
		});

		$(window).on('scroll resize', updateScroll).trigger('scroll');
	}
	anchorEvent() {
		$(document).on('click', 'a[href*="#"]', function(e) {
			e.preventDefault();
	
			const target = this.hash;
			
			if (target) {
				scrollTarget(target);
			}
		});
	}
	gotoTopButton() {
		const $btn = $('.gotoTop');
		const $footer = $('#footer');
		let footerOffset = 0;

		const updateScroll = debounceRAF(() => {
			const innerHeight = $(window).innerHeight();
			
			if ($footer.length > 0) {
				footerOffset = $footer.offset().top;
			}

			toggleHelper($btn, scrollY > innerHeight * 0.6, 'on');
			//toggleHelper($btn, scrollY > footerOffset - innerHeight, 'fixed');
		});

		updateScroll();
		window.addEventListener('scroll', updateScroll);
		window.addEventListener('resize', updateScroll);
	}
	screenZoomIn() {
		const $zoomIn = $('.util_zoomin');
		const $btns = $zoomIn.find('button');
		const $textEl = $zoomIn.find('.zoomin_text');

		const update = (num) => {
			let zoom = nodes.body[0].style.getPropertyValue('zoom') || 1;
			let zoomNum = zoom ? Number(zoom) : 1;

			zoomNum = num === 0 ? 1 : zoomNum + num * 0.1;
			zoomNum = zoomNum > 1.5 ? 1.5 : zoomNum < 0.5 ? 0.5 : zoomNum;
			
			nodes.body.css('zoom', `${zoomNum.toFixed(1)}`);
			nodes.body.toggleClass('zoomIn', zoomNum.toFixed(1) > 1);
			$textEl.text(`${parseInt(zoomNum.toFixed(1) * 100)}%`);
		}

		$btns.on('click', (e) => {
			const val = e.currentTarget.dataset.zoomin;
			let num;
			
			switch(val) {
				case 'up':
					num = 1;
					break;
				case 'down':
					num = -1;
					break;
			/* 	case 'reset':
					num = 0;
					break; */
			}
			update(num);
		});
	}
}

class GnbUI {
	constructor() {
		this.header = $('#header');
		this.navigation = $('#navigation');
		this.gnb = $('.gnb_list');
		this.gnbLi = $('.gnb_li');
		this.gnbLink = $('.gnb_link');
		this.subMenu = $('.gnb_sub_2dth');
		this.sub2dthLi = $('.sub_li_2dth');
		this.sub2dthLink = $('.sub_link_2dth');
		this.openBtn = $('.openNav');
		this.closeBtn = $('.closeNav');
		this.navOpen = false;
		this.subHh = null;

		this.initEvents();
	}
	initEvents() {
		const pcGnbChangeFun = (e) => this.pcGnbChange(e);
		const moGnbChangeFun = (e) => this.moGnbChange(e);
		const naviHanderFun = (e) => this.naviHander(e);

		// 3차 메뉴 체크
		this.sub2dthLi.each((_, item) => {
			const state = $(item).find('.gnb_sub_3dth')[0] ? true : false;
			$(item).find('.sub_link_2dth').data('hasSub', state);
		});

		// 초기화
		const gnbReset = (e) => {
			if (e.target.matches) { // pc
				this.gnbAttrReset('pc'); // reset

				this.openBtn.off('.moHandle');
				this.closeBtn.off('.moHandle');
				this.gnbLink.off('.moHandle');
				this.sub2dthLink.off('.moHandle');

				// event start
				this.gnb.on('mouseleave.pcHandle focusout.pcHandle', pcGnbChangeFun);
				this.gnbLi.on('mouseenter.pcHandle focusin.pcHandle', pcGnbChangeFun);
				this.sub2dthLi.on('mouseenter.pcHandle mouseleave.pcHandle focusin.pcHandle focusout.pcHandle', pcGnbChangeFun);
			
			} else { // mobile
				this.gnbAttrReset('mobile'); // reset

				// clear event
				this.gnb.off('.pcHandle', pcGnbChangeFun);
				this.gnbLi.off('.pcHandle', pcGnbChangeFun);
				this.sub2dthLi.off('.pcHandle', pcGnbChangeFun);

				// event start
				this.openBtn.on('click.moHandle', naviHanderFun);
				this.closeBtn.on('click.moHandle', naviHanderFun);
				this.gnbLink.on('click.moHandle', moGnbChangeFun);
				this.sub2dthLink.on('click.moHandle', moGnbChangeFun);
			}
		};

		$(matchMin(1024)).on('change', gnbReset).change();
	}
	gnbAttrReset(device) {
		if (device === 'pc') {
			if (this.navOpen) {
				this.navOpen = false;
				this.toggleNavi(false, 'reset');

				if (document.activeElement) {
					document.activeElement.blur(); // aria-hidden 오류방지
				}
			}
			toggleAriaSet(this.navigation[0], 'remove', 'aria-hidden');
			
			this.subMenu.each((_, item) => {
				toggleAriaSet(item, 'add', 'aria-hidden');
			});
			this.sub2dthLink.each((_, item) => {
				if ($(item).data('hasSub')) toggleAriaSet(item, 'remove', 'aria-expanded');
			});
			this.gnbLi.each((_, item) => {
				if ($(item).hasClass('active')) this.updateMenu($(item), false, 'reset');
			});

			// 메뉴 선택 초기화
			this.sub2dthLi.each((_, item) => {
				const $subMenu = $(item).find('.gnb_sub_3dth');
				toggleHelper($(item), false, 'active');
				$subMenu.removeAttr('style');
			});	

		} else if (device === 'mobile') {
			toggleAriaSet(this.navigation[0], 'add', 'aria-hidden');
			this.subMenu.each((_, item) => toggleAriaSet(item, 'remove', 'aria-hidden'));
			this.sub2dthLink.each((_, item) => {
				if ($(item).data('hasSub')) toggleAriaSet(item, 'add', 'aria-expanded');
			});

			// 메뉴 선택 초기화
			const $curr1Dth = $('.gnb_link.current');
			const $curr2Dth = $('.sub_link_2dth.current');
			const dth1 = $curr1Dth[0] ? $curr1Dth.parents('.gnb_li').index() : 0;

			this.updateMenu(this.gnbLi.eq(dth1), true);
			if ($curr2Dth[0]) this.updateMenu($curr2Dth.parents('.sub_li_2dth'), true);
		}
	}
	pcGnbChange(e) {
		const type = e.type;
		const target = e.currentTarget;

		// on
		if (type === 'mouseenter' || type === 'focusin') this.toggleMenu(target, true);

		// out
		if (type === 'mouseleave' || type === 'focusout') {
			if (target.matches('.gnb_list')) this.gnbLi.each((_, item) => this.updateMenu($(item), false));
			if (target.matches('.sub_li_2dth')) this.updateMenu($(target), false);
		};
	}
	moGnbChange(e) {
		const target = e.currentTarget;
		const $targetLi = $(target).parent('li');

		if (target.matches('.sub_link_2dth') && !$(target).data('hasSub')) return;

		if (target.matches('.gnb_link') || target.matches('.sub_link_2dth')) {
			e.preventDefault();
			e.stopPropagation();
		}

		if ($targetLi.hasClass('sub_li_2dth')) {
			$targetLi.hasClass('active') 
				? this.updateMenu($targetLi, false) 
				: this.toggleMenu($targetLi, true);
		} else {
			if (!$targetLi.hasClass('active')) this.toggleMenu($targetLi, true);
		}
	}
	naviHander(e) {
		const target = e.currentTarget;
		const state = target.matches('.openNav') ? true : false;

		this.navOpen = state;
		this.toggleNavi(this.navOpen);
	}
	toggleNavi(state, reset) {
		let $gnbFocus;

		nodes.body.toggleClass('navOpen', state);
		this.openBtn.attr('aria-label', state ? '메뉴 닫기' : '메뉴 열기');

		if (state) {
			this.navigation.attr('aria-hidden', false);
			this.navigation.append('<div tabindex="0" data-focus-next="header" class="gnb_focus"></div>');
			this.header.attr({ 'tabindex': 0, 'data-focus': 'header' });
			keyFocus(true);
			noscroll(true);
		} else {
			this.header.removeAttr('tabindex, data-focus');

			$gnbFocus = this.navigation.find('.gnb_focus');
			if ($gnbFocus.length > 0) $gnbFocus.remove();
			keyFocus(false);
			this.openBtn.focus(); // aria-hidden 오류방지

			if (reset) { // 초기화시 모션 적용 X
				noscroll(false);
			} else {
				setTimeout(() => {
					this.navigation.attr('aria-hidden', true);
					noscroll(false);
				}, dur);
			}
		}
	}
	toggleMenu(item) {
		const $item = $(item);
		const $others = $item.siblings();

		this.updateMenu($item, true); // 선택 메뉴

		$others.each((_, el) => { // 선택 외 메뉴
			this.updateMenu($(el), false);

			if (respCheck === 'mobile') {
				const $subMenu = $(el).find('.sub_li_2dth');

				$subMenu.each((_, sub) => {
					if ($(sub).hasClass('active')) this.updateMenu($(sub), false);
				});	
			}
		});
	}
	updateMenu(item, state) {
		toggleHelper(item, state, 'active');
		toggleAria(item, state);

		if (respCheck === 'pc') {
			if ($(item).hasClass('gnb_li')) {
				const $subMenu = item.find('.gnb_sub_2dth');
				toggleHidden($subMenu, state);
			};
	
			toggleHelper(nodes.body, $('.gnb_li.active')[0], 'gnbOn');
		}

		if (respCheck === 'mobile') {
			if ($(item).hasClass('sub_li_2dth')) {
				const $subMenu = item.find('.gnb_sub_3dth');
				state ? $subMenu.stop().slideDown(dur_sld) : $subMenu.stop().slideUp(dur_sld);
			};
		}
	}
} 

class SnbUI {
	constructor() {
		this.snb = $('.snb_list');
		this.snbLi = $('.snb_li');
		this.snbLink = $('.snb_link');
		this.subMenu = $('.snb_sub');
		this.initEvents();
	}
	initEvents() {
		const pcGnbChangeFun = (e) => this.pcGnbChange(e);

		// 2deth 메뉴 체크
		this.snbLi.each((_, item) => {
			const state = $(item).find('.snb_sub')[0] ? true : false;
			$(item).find('.snb_link').data('hasSub', state);
		});

		this.gnbAttrReset(); 

		// 초기화
		const gnbReset = (e) => {
			if (e.target.matches) { // pc
				// event start
				this.snbLink.on('click.pcHandle', pcGnbChangeFun);
			} else { // mobile
				// clear event
				this.snbLink.off('.pcHandle', pcGnbChangeFun);

				if (document.activeElement) {
					document.activeElement.blur(); // aria-hidden 오류방지
				}
			}
		};

		$(matchMin(1024)).on('change', gnbReset).change();
	}
	gnbAttrReset() {
		this.snbLink.each((_, item) => {
			if ($(item).data('hasSub')) {
				$(item).attr('aria-expanded', false);
				$(item).append('<span class="icon"></span>');
			};
		});

		// 메뉴 선택 초기화
		const $currMenu = $('.snb_link.current');
		if ($currMenu[0]) {
			this.updateMenu($currMenu.parents('.snb_li'), true, true)
		};
	}
	pcGnbChange(e) {
		const target = e.currentTarget;
		const $targetLi = $(target).parent('li');

		if (!$(target).data('hasSub')) return;

		e.preventDefault();
		e.stopPropagation();

		$targetLi.hasClass('active') ? this.updateMenu($targetLi, false) : this.toggleMenu($targetLi, true);
	}
	toggleMenu(item) {
		const $item = $(item);
		const $others = $item.siblings();

		this.updateMenu($item, true); // 선택 메뉴

		$others.each((_, el) => { // 선택 외 메뉴
			this.updateMenu($(el), false);
		});
	}
	updateMenu(item, state, reset) {
		toggleHelper(item, state, 'active');
		toggleAria(item, state);

		const $subMenu = item.find('.snb_sub');
		if (reset) {
			if ($subMenu.is(':visible')) $subMenu.hide();
		} else {
			state ? $subMenu.stop().slideDown(dur_sld) : $subMenu.stop().slideUp(dur_sld);
		}
		$subMenu.attr('hidden', !state);
	}
} 

// Accordion
class Accordion {
	constructor(el) {
		this.accordion = $(el);
		this.init();
	}
	init() {
		this.items = this.accordion.find('.accordion_item');
		this.btns =  this.accordion.find('.accordion_btn');

		const activeItem = this.accordion.find('.accordion_item.open');

		if (activeItem) {
			$(activeItem).data('start', true); // 첫 로드 시 data 추가
			this.toggleAccordionItem(activeItem, true);
		}

		this.initEvents();
	}
	initEvents() {
		this.btns.each((idx, btn) => {
			$(btn).on('click', () => {
				const $item = $(btn).parents('.accordion_item');
				const isOpen = $item.hasClass('open');

				isOpen ? this.index = null : this.index = idx;
				this.items.each((idx, item) => this.toggleAccordionItem(item, this.index === idx));
			});
		});
	}
	toggleAccordionItem(item, state) {
		const $btn = $(item).find('.accordion_btn');
		const $content = $(item).find('.accordion_content');

		$(item).toggleClass('open', state);
		toggleAria($btn, state);

		if (this.accordion.hasClass('no_toggle')) return;

		if ($(item).data('start') && state) { // 첫 로드 시 open 요소가 있을 때
			$content.show(); 
			$(item).data('start', false);
		} else {
			state ?  $content.stop().slideDown(dur_sld) : $content.stop().slideUp(dur_sld);
		}
	}
}

// Tab
class Tabs {
	constructor(el) {
		this.tab = $(el);
		this.index = 0;
		this.init();
	}
	init() {
		this.tabList = this.tab.find('.tab_list');
		this.links = this.tab.find('.tab_link');
		this.panels = this.tab.find('.tab_panel');

		// 드롭다운 같이 쓸 경우 (모바일)
		if (this.tab.find('.dropdown[data-device="mobile"]')[0]) {
			this.tab.data('moDrop', true);
		}
		this.initEvents();
	}
	initEvents() {
		this.links.each((_, item) => {
			$(item).on('click', (e) => {
				this.activateTab(item);
			});
		});

		this.tabList.on('keydown focusout', (e) => {
			this.tabListKeydown(e);
		});
		
		this.panels.on('focusout', (e) => {
			this.panelKeydown(e);
		});
	}
	tabListKeydown(e) {
		const { key, target } = e;
		let $next;

		switch(key) {
			case 'ArrowLeft':
				$next = $(target).prev('.tab_link') ? $(target).prev('.tab_link') : null;
				break;
			case 'ArrowRight':
				$next = $(target).next('.tab_link') ? $(target).next('.tab_link') : null;
				break;
			case 'Home':
				e.preventDefault();
				$next = $(this.links).first();
				break;
			case 'End':
				e.preventDefault();
				$next = $(this.links).last();
				break;
			case 'Tab':
				const panelId = $(target).attr('aria-controls');
				const $panel = $(`#${panelId}`);

				if (this.tab.data('moDrop') && respCheck !== 'mobile') {
					if (!$panel.attr('hidden')) $panel.focus();
				} 

				if ($(target).index() !== this.index) {
					const $currentItem = this.panels.eq(this.index);

					$currentItem.attr('tabindex', -1);
					$currentItem.find('a, button').attr('tabindex', -1);

					setTimeout(() => {
						$currentItem.attr('tabindex', 0);
						$currentItem.find('a, button').attr('tabindex', 0);
					}, 1000);
				} 
				break;
			default:
				return;
		}

		if ($next && $next.length > 0) {
			$next.focus();
		} 
	}
	panelKeydown(e) {
		const { currentTarget, target } = e;
		const $panel = $(currentTarget);
		const $links = $panel.find('a, button');
		const $next = this.links.eq(this.index + 1);
		let currentIdx = $links.index(target) + 1;

		if (this.tab.data('moDrop') && respCheck !== 'mobile') {
			if (currentIdx >= $links.length && $next) $next.focus();
		} 
	}
	activateTab(item) {
		const target = $(item).attr('aria-controls');
		this.updateTabs(target);
	}
	updateTabs(target) {
		this.links.each((idx, item) => {
			const state = $(item).attr('aria-controls') === target;
			this.index = state ? idx : this.index;
			$(item).toggleClass('active', state);
			$(item).attr('aria-selected',state);
		});

		this.panels.each((_, item) => {
			const state = $(item).attr('id') === target;
			$(item).attr('hidden',!state);
			$(item).attr('tabindex', state ? 0 : -1);

			if ($(item).parents().attr('data-notrans')) {
				const $panels = $(item).parents('.tab_panels');
				$panels.addClass('notrans');
        setTimeout(() => toggleHelper($panels, false, 'notrans'), dur);
			}
		});
	}
}

/* DropDown */
class DropDown {
	constructor() {
		this.init();
	}
	init() {
		const $activeItem = $('.dropdown.open');
		const $dropdowns = $('.dropdown');

		if ($activeItem[0]) {
			$activeItem.data('start', true); // 첫 로드 시 data 추가
			this.toggleDropdon($activeItem, true);
		}

		// 초기화
		$dropdowns.each((_, dropdowns) => this.dropdownReset(dropdowns));
		this.initEvents();
	}
	initEvents() {
		$(document).on('click', '.dropdown_btn, .dropdown_item', (e) => this.clickHandler(e));
		$(document).on('focusout', '.dropdown_item', (e) => this.keydownHandler(e));
		$(document).on('keydown', (e) => this.allCloseDropdon(e));
	}
	clickHandler(e) {
		const target = e.currentTarget;

		if (target.matches('.dropdown_btn') || target.matches('.dropdown_item')) {
			const $dropdown = $(target).parents('.dropdown');
			let isOpen = $dropdown.data('isOpen') || false;
			const device = $dropdown.data('device');

			if (device && device !== respCheck) return;

			if (target.matches('.dropdown_btn')) { // toggle
				isOpen = !isOpen;
				$dropdown.data('isOpen', isOpen);
				this.toggleDropdon($dropdown, isOpen);
			} else if (target.matches('.dropdown_item')) { // close
				if (isOpen) {
					
					$dropdown.data('isOpen', false);
					this.toggleDropdon($dropdown, false);
				}
				if ($dropdown.data('changetext')) {
					// chagne text
					this.changeBtnText($dropdown);
				}
			}
		}
	}
	dropdownReset(dropdown) {
		const device = $(dropdown).data('device');
		
		const $btn = $(dropdown).find('.dropdown_btn');
		const $content = $(dropdown).find('.dropdown_content');

		const reset = (state) => {
			if (state) {
				let isOpen = $(dropdown).data('isOpen') || false;
				
				if (isOpen) {
					$(dropdown).data('isOpen', false);
					this.toggleDropdon($(dropdown), false);
				}

				if ($(dropdown).data('changetext')) {
					// chagne text
					this.changeBtnText($(dropdown));
				}
			} else {
				if ($(dropdown).hasClass('open')) $(dropdown).removeClass('open');
				if ($(dropdown).data('isOpen')) $(dropdown).data('isOpen', false);
				$btn.removeAttr('aria-expanded');
				$content.removeAttr('style');
			}
		}

		// 	// 초기화
		const breakpoint = (e) => {
			if (e.target.matches) { // pc
				if (device) {
					device === 'mobile' ? reset(false) : reset(true);
				} else {
					reset(true);
				}
			} else { // mobile
				if (device) {
					device !== 'mobile' ? reset(false) : reset(true);
				} else {
					reset(true);
				}
			}
		};

		$(matchMin(1024)).on('change', breakpoint).change();
	}
	keydownHandler(e) {
		const target = e.target;
	
		if (target.matches('.dropdown_item')) {
			const $dropdown = $(target).parents('.dropdown');
			const isFocusInside = $dropdown.has(e.relatedTarget).length > 0;
			const device = $dropdown.data('device');

			if (device && device !== respCheck) return;

			if (!isFocusInside) {
				$dropdown.data('isOpen', false);
				this.toggleDropdon($dropdown, false);
			}
		};
	}
	toggleDropdon(dropdown, state) {
		const $btn = $(dropdown).find('.dropdown_btn');
		const $content = $(dropdown).find('.dropdown_content');
		const labels = $btn.data('label');
		$(dropdown).toggleClass('open', state);
		toggleAria($btn, state);

		if ($(dropdown).data('start') && state) { // 첫 로드 시 open 요소가 있을 때
			$content.show(); 
			$(dropdown).data('start', false);
		} else {
			state ? $content.stop().slideDown(dur_sld) : $content.stop().slideUp(dur_sld);
		}
		// open/close
		if (labels) {
			$btn.attr('aria-label', !state ? labels.open : labels.close);
		}
	}
	allCloseDropdon(e) {
		if (e.key === 'Escape' && $('.dropdown.open')[0]) { 
			$('.dropdown').each((_, dropdown) => {
				if ($(dropdown).data('isOpen')) {
					$(dropdown).data('isOpen', false);
					this.toggleDropdon($(dropdown), false);
				}
			});
		}
	}
	changeBtnText(dropdown) {
		const $btnText = $(dropdown).find('.dropdown_btn .text');
		const $activeBtn = $(dropdown).find('.dropdown_item.active');

		if (!$btnText[0] && $activeBtn[0]) return;

		const text = $btnText.text();
		const activetext = $activeBtn.text();

		if (text !== activetext) $btnText.text(activetext);
	}
}

class toggleBox {
	constructor() {
		this.init();
	}
	init() {
		const $activeItem = $('.toggleBox.open');

		if ($activeItem[0]) {
			$activeItem.data('isOpen', true); // 첫 로드 시 data 추가
			this.toggleBox($activeItem, true);
		}
		
		this.initEvents();
	}
	initEvents() {
		$(document).on('click', (e) => this.clickHandler(e));
		$(document).on('keydown', (e) => this.allCloseBox(e));
	}
	clickHandler(e) {
		const $target = $(e.target);
		if (!$target.hasClass('toggle_btn')) return;

		e.preventDefault();
		const $cont = $target.parents('.toggleBox');
		let isOpen = $cont.data('isOpen') || false;
		isOpen = !isOpen;
		$cont.data('isOpen', isOpen);
		this.toggleBox($cont, isOpen);
	}
	toggleBox(cont, state) {
		requestAnimationFrame(() => {
			$(cont).toggleClass('open', state);
		});
		transHelper($(cont), state);
	}
	allCloseBox(e) {
		if (e.key === 'Escape' && $('.toggleBox.open')[0]) { 
			$('.toggleBox').each((_, box) => {
				if ($(box).data('isOpen')) {
					$(box).data('isOpen', false);
					this.toggleBox($(box), false);
				}
			});
		}
	}
}

// Modal
class Modal {
	constructor() {
		this.initEvents();
	}
	initEvents() {
		$(document).on('click', (e) => this.clickHandler(e));
		$(document).on('keydown', '.modal', (e) => this.keydownHandler(e));
	}
	clickHandler(e) {
		const target = e.target;

		if (target.matches('.openModal')) {
			e.preventDefault();
			const modal = $(target).data('target');
			this.openModal(modal, target);
		} else if (target.matches('.closeModal')) {
			e.preventDefault();
			const $modal = $(target).parents('.modal');
			if ($modal.length > 0) this.closeModal(`#${$modal.attr('id')}`);
		} else if (target.matches('.dim')) {
			e.preventDefault();
			this.closeAllModals();
		}
	}
	keydownHandler(e) {
		if (e.key === 'Escape') {
			this.closeAllModals();
		}
	}
	openModal(target, openBtn) {
		const $modal = $(target);
		if ($modal.length === 0) return;

		$modal.attr('tabindex', '0').fadeIn(dur).addClass('open').focus();
		keyFocus(true);
		dimToggle(true);

		if (openBtn) { // 오픈 버튼 정보 저장
			$modal.data('openBtn', openBtn);
		}
	}
	closeModal(target) {
		const $modal = $(target);
		if ($modal.length === 0) return;

		$modal.attr('tabindex', '-1').fadeOut(dur);
		keyFocus(false);
		dimToggle(false);

		setTimeout(() => {
			$modal.removeClass('open');
		}, dur);

		if ($modal.data('openBtn')) {
			$modal.data('openBtn').focus();
			$modal.data('openBtn', null);
		}
	}
	closeAllModals() {
		const $modals = $('.modal.open');
		$modals.each((_, modal) => this.closeModal(`#${$(modal).attr('id')}`));
	}
}

// 가로 swipe class
class SwipeArea {
	constructor(el) {
		this.swipe = $(el);
		this.inner = this.swipe.find('.inner');
		this.table = this.swipe.find('table');
		this.isScroll = false;
		this.isDragging = false;
		this.startX = 0;
		this.scrollLeft = 0;
		this.swipeHandler = this.swipeEvents.bind(this);
		this.handleResize = debounceRAF(this.updateScrollState.bind(this));
		this.initEvents();
	}
	initEvents() {
		this.updateScrollState();
    $(window).on("resize", this.handleResize);

		// table event
		if (this.table.length > 0) {
			const swipeTableFun = debounceRAF(() => this.swipeTable(this.table));
			$(window).on('resize', swipeTableFun).trigger('resize');
		}

		// get dataset
		const { type } = this.swipe.data();
		if (type === 'nav') this.swipeNav();
	}
	updateScrollState() {
		const isScroll =   this.swipe[0].clientWidth <  this.inner[0].scrollWidth;

		if (this.isScroll !== isScroll) {
			this.isScroll = isScroll;
			toggleHelper(this.swipe, this.isScroll, 'scroll');
		}

		this.manageEvents(this.isScroll);
	}
	manageEvents(state) {
		const events = ['mousedown', 'mouseup', 'mouseleave', 'touchstart', 'touchend'];
		const moveEvents = ['mousemove', 'touchmove'];
		
		events.forEach((event) => {
			if (state) {
				this.swipe.on(event, this.swipeHandler);
			} else {
				this.swipe.off(event, this.swipeHandler);
			}
		});
		moveEvents.forEach((event) => {
			if (state) {
				this.swipe.on(event, this.swipeHandler);
			} else {
				this.swipe.off(event, this.swipeHandler);
			}
		});
	}
	swipeEvents(e) {
		switch (e.type) {
			case 'mousedown':
			case 'touchstart':
				this.startDragging(e);
				break;
			case 'mouseup':
			case 'mouseleave':
			case 'touchend':
				this.stopDragging();
				break;
			case 'mousemove':
			case 'touchmove':
				if (this.isDragging) {
					this.handleDragging(e);
				}
				break;
		}
	}
	startDragging(e) {
		this.isDragging = true;

		if (isMobile) return;
		const startX = e.pageX - this.swipe[0].offsetLeft;
		const scrollLeft = this.swipe[0].scrollLeft;

		if (this.startX !== startX) this.startX = startX;
		if (this.scrollLeft !== scrollLeft) this.scrollLeft = scrollLeft;
	}
	stopDragging() {
		this.isDragging = false;
		toggleHelper(this.swipe, false, 'moving');
	}
	handleDragging(e) {
		toggleHelper(this.swipe, true, 'moving');

		if (isMobile) return;
		e.preventDefault();
		
		const x = e.pageX - this.swipe[0].offsetLeft;
		const walk = (x - this.startX) * 2; 
		this.swipe[0].scrollLeft = this.scrollLeft - walk;
	}
	swipeTable(table) {
		const $cols = $(table).find('col.sticky');

		if ($cols.length === 0) return;
		const colWidths = [...$cols].map((col) => col.clientWidth);
		const totalWidth = colWidths.reduce((sum, width) => sum + width, 0);

		$(table).find('tr').each((_, tr) => {
			$(tr).find('.sticky').each((i, cell) => {
				const width = colWidths[i - 1];

				if (width) {
					cell.style.setProperty('--lt', `${width}px`);
				}
			});
		});

		$(table).parents('.tbl')[0].style.setProperty('--lt', `${totalWidth}px`);
	}
	swipeNav() {
		const $currentItem = this.swipe.find('.current, .active');

		if ($currentItem.length > 0 && !this.isScroll) {
			//$currentItem[0].scrollIntoView({ inline: 'nearest' });
			const posX =  $currentItem.offset().left - this.swipe.offset().left;
			this.swipe[0].scrollBy({left: posX});
		}
	}
}

// 셀렉트 초기화
class Forms {
	constructor(el) {
		this.el = el;
		this.init();
	}
	init() {
		const type = this.el.dataset.forms;

		switch(type) {
			case 'select':
				if (!isMobile) this.customSelect();
				break;
			case 'file':
				this.attachFile();
				break;
			default:	
			return;
		}
	}
	customSelect() {
		loadAssets(
			[
        { url: './_assets/js/jquery.nice-select.min.js', type: 'script' },
      ],
			() => {
				if (typeof $.fn.niceSelect !== 'undefined') {
					customSelect();
				}
		});
	}
	attachFile() {
		const $el = $(this.el);
		const $file = $el.find('input[type="file"]');
		const place = $file.attr('placeholder');
		const $input = $el.find('.frm_input');

		$file.on('change', function() {
			$input.empty().append(this.value);

			if ($input.hasClass('place')) $input.removeClass('place');
		});
	}
}

// Custom Select 
class CustomSelect {
	constructor() {
		this.init();
	}
	init() {
		if ($('.nice-select').length > 0) {
			$('.frm_select').niceSelect('destroy');
		} 

		$('select.frm_select').niceSelect();

		this.initEvents();
	}
	initEvents() {
		const toggleSelectFun = (el) => this.toggleSelect(el);
		const closeSelectFun = (e) => this.closeSelect(e);

		$(document).on('click.nice_select', '.nice-select', function() {
			toggleSelectFun(this);
		});
		// Close when clicking outside
		$(document).on('click.nice_select', function(event) {
			closeSelectFun(event);
		});
	}
	toggleSelect(el) {
		const $dropdown = $(el);
		const $list = $dropdown.find('.list');
		const isOpen = $dropdown.hasClass('open');
		const $selectedItem = $dropdown.find('.selected');

		$('.nice-select').not($dropdown).find('.list').stop().slideUp(dur_sld);

		if (isOpen) {
			$list.stop().slideDown(dur_sld);

			if (!$list.data('start') && $selectedItem.length > 0) {
				this.scrollToSelectedItem($selectedItem, $list);
				$list.data('start', true);
			}
		} else {
			$list.stop().slideUp(dur_sld);
		}
	}
	closeSelect(event) {
		if ($(event.target).closest('.nice-select').length === 0) {
			$('.nice-select').find('.list').stop().slideUp(dur_sld);
		}
	}
	scrollToSelectedItem(selectedItem, list) {
		const { offsetTop, clientHeight } = selectedItem[0];

		if (list.length > 0 && list[0].clientHeight < offsetTop + clientHeight) {
			selectedItem[0].scrollIntoView({block: 'nearest'});
		}
	}
}

const accordion = () => {
	$('.accordion').each((_, accordion) => new Accordion(accordion));
}

const tabs = () => {
	$('.tabs').each((_, tab) => new Tabs(tab));
}

// 가로 swipe
const swipeEvent = () => {
	$('.swipearea').each((_, swipearea) => new SwipeArea(swipearea));
}

const dropDown = () => {
	if ($('.dropdown').length > 0) new DropDown();
	if ($('.toggleBox').length > 0) new toggleBox();
};

const modal = () => {
	if ($('.openModal').length > 0) new Modal();
};

const swiperSlider = () => {
	$('.slider').each((_, slider) => initSliders(slider));
	$('.gallery_slider').each((_, slider) => initSliders(slider));
}

// 셀렉트 초기화
const customSelect = () => {
	if (isMobile) return;

	if ($('select.frm_select').length > 0) new CustomSelect();
};

// 셀렉트 업데이트
const updateSelect = (select) => {
	if (isMobile) return;

	$(select).niceSelect('update');
}

const fromsEvent = () => {
	$('[data-forms]').each((_, forms) => new Forms(forms));
}

const initCommon = () => new Common();
const initNavigation = () => {
	if ($('#gnb').length > 0) new GnbUI();
	if ($('#snb').length > 0) new SnbUI();
};

const initPlugins = () => [accordion, tabs, dropDown, modal, swipeEvent, swiperSlider, fromsEvent].forEach(fn => fn());

initCommon();
initNavigation();
initPlugins();
