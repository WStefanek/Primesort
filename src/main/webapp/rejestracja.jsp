<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Primesort - Rejestracja</title>
    <link rel="shortcut icon" type="image/png" href="favicon.png"/>
    <!--Podpięcie pliku stylu Bootstrap oraz dodatkowych czcionek-->
    <link href="lib/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
    <!--Własny plik CSS-->
    <link href="styles/style.css" rel="stylesheet">
</head>
<body class="bg-c-white py-5" style="align-items: center;">
<c:choose>
    <c:when test="${sessionScope.loggedAs!=null}">
        <%
            response.sendRedirect("/primesort");
        %>
    </c:when>
    <c:otherwise>
        <form id="register" name="register" action="register" method="post" class="form-signin text-center mx-auto">
            <a href="/primesort"><img src="img/logo-adv.png" alt="logo-adv" class="mb-4" width="120" height="120"></a>
            <h3 class="mb-3">Zarejestruj się w Primesort</h3>
            <div class="mb-3 form-floating">
                <input id="input-name" name="name" class="form-control" placeholder="Nazwa" type="text" autocomplete="off" required>
                <label for="input-name" class="form-label">Nazwa</label>
                <div class="text-start text-danger" name="input-name-msg"></div>
            </div>
            <div class="mb-3 form-floating">
                <input id="input-email" name="email" class="form-control" placeholder="E-mail" type="email" autocomplete="off" required>
                <label for="input-email" class="form-label">E-mail</label>
                <div class="text-start text-danger" name="input-email-msg"></div>
            </div>
            <div class="mb-3 form-floating">
                <input id="input-password" name="password" class="form-control" placeholder="Hasło" type="password" autocomplete="off" required>
                <label for="input-password" class="form-label form-floating">Hasło</label>
                <div class="text-start text-danger" name="input-password-msg"></div>
            </div>
            <div class="mb-3 form-floating">
                <input id="input-reppassword" name="reppassword" class="form-control" placeholder="Powtórz hasło" type="password" autocomplete="off">
                <label for="input-reppassword" class="form-label form-floating">Powtórz hasło</label>
                <div class="text-start text-danger" name="input-repassword-msg"></div>
            </div>
            <button type="submit" class="btn btn-primary mb-3">Zarejestruj się</button>
            <p id="register-response" class="<%if(request.getAttribute("color")!=null) out.print(request.getAttribute("color"));%>"><%if(request.getAttribute("msg")!=null) out.print(request.getAttribute("msg"));%></p>
            <hr/>
            <span>Masz już konto?<br/><a class="link-primary text-decoration-none" href="logowanie">Zaloguj się!</a></span>
        </form>
    </c:otherwise>
</c:choose>
    <!--Podpięcie plików skryptowych JQuery oraz Bootstrap-->
    <script src="lib/jquery-3.6.0.min.js"></script>
    <script src="lib/jquery.validate.min.js"></script>
    <script src="lib/bootstrap.bundle.min.js"></script>
    <!--Własny plik JavaScript-->
    <script src="scripts/script.js"></script>
    <script src="scripts/form-validation.js"></script>
</body>
</html>
