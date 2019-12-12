'use strict';

let x;
let y;
let r;

window.onload = () => $('#execute').prop('disabled',true);

function resetDisable() {
    $('#execute').prop('disabled',false);
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
        let element = document.createElement('form');
        element.method = 'GET';
        element.action = 'lab2';
        element.type = 'hidden';

        element.innerHTML = "<input type='hidden' name='x' value="+ x +">"+
            "<input type='hidden' name='y' value="+ y +">" +
            "<input type='hidden' name='r' value=" + r + ">";

        document.body.appendChild(element);
        element.submit();
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