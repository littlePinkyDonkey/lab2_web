'use strict';

let x;
let y;
let r;

function getValues() {
    x = $('.x_value:checked').val();
    y = $('#y_value').val().replace(',','.');
    r = $('#r_value').val().replace(',','.');
    localStorage.setItem('r',r);
}

function validate() {
    getValues();

    return !(x === undefined || y === "" || r === "" || isNaN(y)
        || isNaN(r) || y <= -3 || y >= 5 || r <= 2 || r >= 5);
}

function send() {
    if (validate()) {
        $.ajax({
            type: 'GET',
            url: `lab2?x=${x}&y=${y}&r=${r}`,
            success: function (response) {
                location.reload();
            }
        });
    }else {
        $.growl.error({ message: "Проверьте правильность введённых данных!" });
    }
}

function canvasSend(x, y, r) {
    $.ajax({
        type: 'GET',
        url: `lab2?x=${x}&y=${y}&r=${r}`,
        success: function (response) {
            location.reload();
        }
    });
}