$(document).ready(
    function(){
        $.validator.setDefaults({
            highlight: function(element){
                $(element).addClass('is-invalid');
            },
            unhighlight: function(element){
                $(element).removeClass('is-invalid');
            }
        });
        $("form[name='register']").validate({
            rules:{
                name: {required: true, maxlength: 30},
                email: {required: true, email: true},
                password: {required: true, minlength: 8},
                reppassword: {required: true, equalTo: "#input-password"}
            },
            messages:{
                name: {required: "Musisz ustawić nazwę", maxlength: "Nazwa nie może przekraczać 30 znaków"},
                email: "Musisz podać prawidłowy adres e-mail",
                password: {required: "Musisz ustawić hasło", minlength: "Hasło musi mieć conajmniej 8 znaków"},
                reppassword: {required: "Musisz powtórzyć hasło", equalTo: "Oba hasła muszą być identyczne"}
            },
            errorPlacement: function(error, element){
                error.appendTo( element.next().next());
            }
        });

        $("form[name='loginForm']").validate({
            rules:{
                email: {required: true, email: true},
                password: {required: true, minlength: 8},
            },
            messages:{
                email: "Musisz podać prawidłowy adres e-mail",
                password: {required: "Musisz podać hasło", minlength: "Hasło musi mieć conajmniej 8 znaków"},
            },
            errorPlacement: function(error, element){
                error.appendTo( element.next().next());
            }
        });

    }
);