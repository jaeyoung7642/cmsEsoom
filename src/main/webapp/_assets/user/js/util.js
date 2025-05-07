// breakpoint
const matchMax = (num) => window.matchMedia('(max-width:' + num + 'px)');
const matchMin = (num) => window.matchMedia('(min-width:' + num + 'px)');

// parse data
const parseData = (data) => JSON.parse(data);

// class helper
const toggleHelper = (el, factor, cssName) => {
	if (factor && !el.hasClass([cssName])) {
		el.addClass([cssName]);
	} else if (!factor && el.hasClass([cssName])) {
		el.removeClass([cssName]);
	}
};

// transition
const transHelper = (el, state) => {
	if (state) {
		el.addClass('show');
	} else {
		setTimeout(() => {
			el.removeClass('show');
		}, dur);
	}
}

const formaNumber = (num) => String(num).padStart(2, '0');

// debounce
const debounceRAF = (func) => {
	let ticking = false;

	return function(...args) {
		if (!ticking) {
			requestAnimationFrame(() => {
				func.apply(this, args);
				ticking = false;
			});
			ticking = true;
		}
	}
};

// scroll target
const scrollTarget = (target) => {
	const offsetTop = $(target).offset().top;
		$('html, body').animate({
			scrollTop: offsetTop
		}, 500);
};

// aria set
const toggleAriaSet = (item, factor, cmd) => {
	if (factor === 'remove' && item.hasAttribute(cmd)) {
		$(item).removeAttr(cmd);
	} else if (factor === 'add' && !item.hasAttribute(cmd)) {
		$(item).attr(cmd, true);
	}
}

const toggleAria = (item, state) => {
	if (item.length === 0) return;
	const $item = item[0].matches('li') ? $(item).children('a') : $(item);
	$item.attr('aria-expanded', state);
}

const toggleHidden = (item, state) => {
	if (item.length === 0) return;
	const $item = $(item);
	$item.attr('aria-hidden', !state);
}

// keyFocus
const keyFocus = (state) => {
	if (state) {
		$(document).on('keydown', keyFocusHandler);
	} else {
		$(document).off('keydown', keyFocusHandler);
	}
}   

const keyFocusHandler = (e) => {
	const $target = $(e.target);

	if (!$target.attr('data-focus-prev') && !$target.attr('data-focus-next')) return;

	const next = $target.attr('data-focus-next');
	const prev = $target.attr('data-focus-prev');
	const focusTarget = next || prev || false;

	if($target.length === 0 || e.keyCode != 9) return;

	if( (!e.shiftKey && next) || (e.shiftKey && prev) ) {
		const $focusEl = $(`[data-focus="${focusTarget}"]`);
		if ($focusEl.length > 0) $focusEl.focus();
	} 
};

const noscroll = (state) => $('body').toggleClass('noscroll', state);

// dim on/off
const dimToggle = (state) => {
	const addDim = () => {
		if ($('.dim').length > 0) return;

		$('body').append('<div class="dim"></div>');
		$('.dim').fadeIn(300);
		noscroll(true);
	}

	const removeDim = () => {
		if ($('.dim').length === 0) return;
		$('.dim').fadeOut(300);

		setTimeout(() => {
			$('.dim').remove();
			noscroll(false);
		}, 300);
	};

	state ? addDim() : removeDim();
}

// add script
const loadAssets = (() => {
  const loadedAssets = new Map(); // 로드된 자산 상태를 관리

  return (assets, callback) => {
    // 모든 자산을 병렬로 로드하기 위한 배열
    const promises = assets.map(({ url, type }) => {
      const absoluteUrl = new URL(url.replace('_assets/','/esoomCms/_assets/user/'), window.location.origin).toString();
			//const absoluteUrl = new URL(url, window.location.origin).toString(); // local
	  //console.log(absoluteUrl);

      // 이미 로드된 자산이 있다면 그 Promise를 바로 반환
      if (loadedAssets.has(absoluteUrl)) {
        return loadedAssets.get(absoluteUrl);
      }

      const promise = new Promise((resolve, reject) => {
        let element;

        if (type === 'script') {
          element = document.createElement('script');
          element.src = absoluteUrl;
          element.defer = true;
        } else if (type === 'css') {
          element = document.createElement('link');
          element.href = absoluteUrl;
          element.rel = 'stylesheet';
        } else {
          return reject(new Error(`Unsupported asset type: ${type}`));
        }

        element.onload = () => resolve();
        element.onerror = () => {
          console.error(`Failed to load asset: ${absoluteUrl}`);
          reject(new Error(`Failed to load asset: ${absoluteUrl}`));
        };

        document.head.appendChild(element);
      });

      // 로딩 상태를 Map에 저장하여 중복 로드를 방지
      loadedAssets.set(absoluteUrl, promise);

      return promise;
    });

    // 모든 자산 로드가 완료되면 callback 호출
    Promise.all(promises)
      .then(callback)
      .catch((error) => console.error('Asset loading error:', error));
  };
})();