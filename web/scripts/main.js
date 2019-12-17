'use strict';

let x;
let y;
let r;

function reset() {
    x = 0;
    y = 0;
    r = 0;
    document.getElementById('y_value').value = '';
    document.getElementById('r_value').value = '';
    document.querySelector('input[type="radio"]:checked').checked = false;
}

function getValues() {
    x = $('.x_value:checked').val();
    y = $('#y_value').val().replace(',','.');
    r = $('#r_value').val().replace(',','.');
}

function validate() {
    getValues();

    return !(x === undefined || y === "" || r === "" || isNaN(y) || isNaN(r) || y <= -3 || y >= 5 || r <= 2 || r >= 5);
}

function send() {
    if (validate()) {
        $.ajax({
            type: 'GET',
            url: `lab2?x=${x}&y=${y}&r=${r}&control_value=form`,
            success: function (response) {
                location.reload();
            }
        });
    }else {
        $.growl.error({ message: "Проверьте правильность введённых данных!" });
    }

    // if (!validate()){
    //     resetInput();
    // }else {
    //     $.growl({ title: "Growl", message: "Проверьте правильность введённых данных!" });
    //     $.growl.error({ message: "Проверьте правильность введённых данных!" });
    //     $.growl.notice({ message: "Проверьте правильность введённых данных!" });
    //     $.growl.warning({ message: "Проверьте правильность введённых данных!" });
    // }
}