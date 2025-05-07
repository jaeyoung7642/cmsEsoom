$(function(){
	inputValue();
});

function inputValue() {
	const $input = $('.js-value');

	$input.each((idx, item) => {
		let val = $(item).val().length;
		
		inputOn(item, val);

		$(item).on('keyup', () => {
			val = $(item).val().length;

			inputOn(item, val);
		});
	});

	function inputOn(el, val) {
		if (val > 0) {
			$(el).addClass('on');
		} else {
			$(el).removeClass('on');
		}
	}
}
