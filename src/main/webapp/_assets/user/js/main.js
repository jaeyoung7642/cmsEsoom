// svg anim center
const pathCenter = (path) => {
	const bbox = path.getBBox();
	const { x, y, width, height } = bbox;
	const centerX = x + width / 2;
	const centerY = y + height / 2;
	$(path).css('transform-origin', `${centerX}px ${centerY}px`);
}

const mainSvgAnim = () => {
	const $pcPaths = $('.bg_svg.m_hide path');
	const $moPaths = $('.bg_svg.m_show path');

	// 초기화
	const breakpoint = (e) => {
		if (e.target.matches) { // pc
			$pcPaths.each((_, path) => {
				pathCenter(path);
			});
		} else { // mobile
			$moPaths.each((_, path) => {
				pathCenter(path);
			});
		}
	};

	$(matchMin(768)).on('change', breakpoint).change();
}

$(function() {
	mainSvgAnim();
});