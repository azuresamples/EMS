/**
 * bootstrap alertをx秒後に消す
 */

$(function(){
	$('.alert').fadeIn('show');
	setTimeout(function(){
		$('.alert').fadeOut('show');
	},3000);

	$('.calendar').datetimepicker({
		  format: 'YYYY-MM-DD',
		  language: 'ja'
		}).on('dp.error', function(e) {
		  $(e.target).val('');
		});

});


/**
 *
 */
function ExecutionCheck() {
	if (confirm("実行してもよろしいですか？")) {
		return true;
	} else {
		return false;
	}
}

function radioCheck(num) {
	// i番目のラジオボタンがチェックされているかを判定
	if (num == 1) {
		document.getElementById("return").style.display = "block";

		// 要素をid属性を指定して取得
		var target = document.getElementById("target");

		target.setAttribute("required", "required");
	} else {
		document.getElementById("return").style.display = "none";
		// 要素をid属性を指定して取得
		var target = document.getElementById("target");

		target.removeAttribute("required");

		document.getElementById("target").value = "";
	}
}

function csvDownload() {
    var filename = "ems.csv";
    var text = document.getElementById("csv").value;
    console.log("filename:");
    console.log(filename);
    console.log("text:");
    console.log(text);
    var blob = new Blob([text], {type: "text/plain"});
    var url = window.URL.createObjectURL(blob);
    document.getElementById("download-link").href = url;
    document.getElementById("download-link").download = filename;
}

function dateCheck() {
    var date1 = new Date("start_date");
    var date2 = new Date("return_date");

    function lowerThanDateOnly(date1, date2) {
        var year1 = date1.getFullYear();
        var month1 = date1.getMonth() + 1;
        var day1 = date1.getDate();

        var year2 = date2.getFullYear();
        var month2= date2.getMonth() + 1;
        var day2 = date2.getDate();

        if (year1 == year2) {
            if (month1 == month2) {
                return day1 < day2;
            }
            else {
                return month1 < month2;
            }
        } else {
            return year1 < year2;
        }
    }

    console.log(lowerThanDateOnly(date1, date2));
    console.log(lowerThanDateOnly(date1, date3));
}


