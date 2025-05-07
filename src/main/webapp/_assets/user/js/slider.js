class SwiperSlider {
	constructor(el) {
		this.el = el;
		this.slider = el.classList.contains('swiper') ? el : el.querySelector('.swiper');
		this.device_pc = {};
		this.device_tablet = {};
		this.delay = 2500;
		this.speed = 600;
		this.options = {
			speed: this.speed,
			observer: true,
			observeParents: true
		};
		this.totalSld;
		this.init();
	}
	init() {
		this.nextBtn = this.el.querySelector('.swiper-button-next');
		this.prevBtn = this.el.querySelector('.swiper-button-prev');
		this.page = this.el.querySelector('.swiper-pagination');
		this.player = this.el.querySelector('.player');
		this.totalSld = this.slider.querySelectorAll('.swiper-slide').length;
		this.initEvents();
	}
	initEvents() {
		// option update
		const updateOptions = (newOptions) => {
			this.options = { ...this.options, ...newOptions };
		};

		const freeModeOp = {
			enabled: true,
			sticky: true,
		}

		const responsiveUpdate = (value, optionName) => {
			const array = parseData(value);
			const devices = [this.device_pc, this.device_tablet];

			array.forEach((d, i) => {
				if (optionName === 'slidesPerView') {
					d = d === 0 ? 'auto' : d;
				}

				if (i < devices.length && devices[i]) {
					devices[i][optionName] = d;

					if (d === 'auto') {
						devices[i]['freeMode'] = freeModeOp;
					}
				} else if (i === 2) {
					if (d === 'auto') {
						updateOptions({ [optionName]: d,  ['freeMode']: freeModeOp});
					} else {
						updateOptions({ [optionName]: d });
					}
					
				}
				
			});

			updateOptions({
				breakpoints: {
					768: this.device_tablet,
					1024: this.device_pc,
				}
			});
		}

		// get dataset
		const { options, view, space, group, autoplay } = this.slider.dataset;

		// add options
		if (options) updateOptions(parseData(options));

		// Space between
		if (space) responsiveUpdate(space, 'spaceBetween');

		// Slides per view
		if (view) {
			responsiveUpdate(view, 'slidesPerView');
			if (group === 'true') responsiveUpdate(view, 'slidesPerGroup');
		};

		// Autopaly 
		if (autoplay) {
			const delayValue = autoplay === 'true' ? this.delay : Number(autoplay);

			updateOptions({
				autoplay: {
					delay: delayValue,
					disableOnInteraction: false,
				},
			});
		}

		// Navigation
		if (this.prevBtn && this.nextBtn) {
			updateOptions({
				navigation: {
					nextEl: this.nextBtn,
					prevEl: this.prevBtn,
				}
			});
		};

		// progress
		const initProgress = (totalSld, totalNum, currentNum, delay) => {
			this.page.style = `--speed: ${delay}ms`;

			updateOptions({
				pagination: {
					el: this.page,
					bulletClass: 'progressbar',
					bulletActiveClass: 'on',
				},
				on: {
					init: function() {
						let current = this.realIndex;
						totalNum.innerText = formaNumber(totalSld);
						currentNum.innerText = formaNumber(current + 1);
					}
				}
			});
		}

		// Pagination
		if (this.page) {
			const pageType = this.page.dataset?.type;

			if (pageType === 'progress') {
				this.totalNum = this.el.querySelector('.totalNum');
				this.currentNum = this.el.querySelector('.currentNum');
				initProgress(this.totalSld, this.totalNum, this.currentNum, this.delay);
			} else {
				updateOptions({
					pagination: {
						el: this.page,
						clickable: true,
						type: pageType ?? 'bullets',
					}
				});
			}
		}

		requestAnimationFrame(() => {
			this.swiper = new Swiper(this.slider, this.options);

			// AutoPlay Observer 
			if (autoplay) {
				this.autoPlayObserver(this.swiper, this.slider);
			}

			// play/stop
			if (this.player) {
				const autoPlayControl = () => {
					const autoPlay = this.swiper.autoplay;
					const state = autoPlay.running;
					state ? autoPlay.stop() : autoPlay.start();
					this.autoPlayUpdate(state);
				}

				this.player.addEventListener("click", () => autoPlayControl());
			}

			if (this.page) {
				const pageType = this.page.dataset?.type;
				if (pageType !== 'progress') return;
				const updateProgressFun = (page, newSpeed) => this.updateProgress(page, newSpeed);

				const page = this.page;
				const currentNum = this.currentNum;
				const newSpeed = `${this.delay + this.speed}ms`;
				updateProgressFun(page);
				
				this.swiper.on('slideChange', function() {
					let current = this.realIndex;
					currentNum.innerText = formaNumber(current + 1);
					updateProgressFun(page, newSpeed);
				});
			}
		});
	}
	autoPlayObserver(swiper, slider) {
		const autoPlay = swiper.autoplay;

		const observer = new IntersectionObserver(
			(entries) => {
				entries.forEach((entry) => {
					entry.isIntersecting ? autoPlay.start() : autoPlay.stop();
					this.autoPlayUpdate(!entry.isIntersecting);
				});
			},
			{ threshold: 0.15 }
		);

		observer.observe(slider);
	}
	// autoPlay update
	autoPlayUpdate(state) {
		this.player.setAttribute('aria-label', !state ? '일시정지' : '재생');
		this.player.classList.toggle('stop', !state);

		const progress = this.el.querySelector('[data-type="progress"]');

		if (progress) {
			if (state) {
				progress.classList.add('stop');
			} else {
				const activeBar = progress.querySelector('.progressbar.on');
				progress.classList.remove('stop');
				activeBar.classList.remove('on');

				requestAnimationFrame(() => {
					activeBar.classList.add('on');
				});

				const newSpeed = `${this.delay}ms`;
				this.updateProgress(this.page, newSpeed);
			}
		};
	}
	// progress speed update
	updateProgress(page, newSpeed) {
		const currentSpeed = getComputedStyle(page).getPropertyValue("--speed").trim();

		if (newSpeed !== undefined && currentSpeed !== newSpeed) {
			page.style.setProperty("--speed", newSpeed);
		}
	}
}

class SwiperGalery {
	constructor(el) {
		this.el = el;
		this.bigImgSlider = this.el.querySelector('.gallery_bigimg');
		this.thumbSlider = this.el.querySelector('.gallery_thumb');
		this.swipers = {}
		this.initEvents();
	}
	initEvents() {
		let thumbOption = {
			spaceBetween: 10,
			slidesPerView: 2,
			slidesPerGroup: 2,
			breakpoints: {
				576: {
					slidesPerView: 3,
					slidesPerGroup: 3,
				},
				768: {
					slidesPerView: 4,
					slidesPerGroup: 4,
				},
				992: {
					slidesPerView: 5,
					slidesPerGroup: 5,
				},
				1480: {
					slidesPerView: 6,
					slidesPerGroup: 6,
				},
			},
		}

		this.initSlider('thumb', this.thumbSlider, thumbOption);
		this.initSlider('bigImg', this.bigImgSlider);

	
	}
	initSlider(key, el, options = {}) {
		let initOption = {
			...options
		}

		const slider = el.querySelector('.swiper');
		const nextBtn = el.querySelector('.swiper-button-next') || null;
		const prevBtn = el.querySelector('.swiper-button-prev') || null;

		const updateOptions = (newOptions) => {
			initOption = { ...initOption, ...newOptions };
		};

		// Navigation
		if (prevBtn && nextBtn) {
			updateOptions({
				navigation: {
					nextEl: nextBtn,
					prevEl: prevBtn,
				}
			});
		};

		requestAnimationFrame(() => {
			let swiper;

			if (key === 'bigImg' && this.swipers["thumb"]) {
				updateOptions({
					spaceBetween: 20,
					thumbs: {
						swiper: this.swipers["thumb"],
					},
				});
			}

			swiper = new Swiper(slider, initOption);
			this.swipers[key] = swiper;

			// 버튼 컨트롤
			if (this.swipers['thumb']) {
				this.setSlideKeyEvents(this.swipers);
			}
		}); 
	}
	setSlideKeyEvents(swipers) {
		const thumbBtns = this.thumbSlider.querySelectorAll('.thumb_btn');
		const inputs = this.thumbSlider.querySelectorAll('.frm_checkbox');

		thumbBtns.forEach((btn) => {
			btn.addEventListener('keydown', function(e) {
				if (e.key === "Enter" || e.keyCode === 13) {
					const index = this.dataset.index;
					swipers['thumb'].slideTo(index);
					swipers['bigImg'].slideTo(index);
				}
			});
		});

		inputs.forEach((input) => {
			input.addEventListener('touchstart', (e) => {
				e.stopPropagation();
			});
		
			input.addEventListener('pointerdown', (e) => {
				e.stopPropagation();
			});
		});
	}
}

const initSliders = (slider) => {
	loadAssets(
		[
			{ url: './_assets/js/swiper-bundle.min.js', type: 'script' },
			{ url: './_assets/css/swiper-bundle.min.css', type: 'css' },
		],
		() => {
			if (typeof Swiper !== 'undefined') {
				if (slider.matches('.gallery_slider')) {
					new SwiperGalery(slider); // 갤러리 스타일
				} else {
					new SwiperSlider(slider);
				}
			}
	});
}