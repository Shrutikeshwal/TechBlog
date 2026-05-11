<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow">

                <!-- Card Header -->
                <div class="card-header text-center">
                    <h3>User Registration</h3>
                </div>

                <!-- Form Start -->
                <form id="reg-form"
                      action="${pageContext.request.contextPath}/RegisterServlet"
                      method="post">

                    <!-- Card Body -->
                    <div class="card-body">

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text"
                                   name="name"
                                   class="form-control"
                                   placeholder="Enter your name"
                                   required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="Enter your email"
                                   required>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password"
                                   name="password"
                                   class="form-control"
                                   placeholder="Enter password"
                                   required>
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-3">
                            <label class="form-label">Confirm Password</label>
                            <input type="password"
                                   name="confirmPassword"
                                   class="form-control"
                                   placeholder="Confirm password"
                                   required>
                        </div>

                        <!-- Gender -->
                        <div class="form-group">
                            <label>Select Gender</label><br>

                            <input type="radio" name="gender" value="Male" required> Male
                            <input type="radio" name="gender" value="Female" required> Female
                        </div>

                        <!-- About -->
                        <div class="form-group mt-3">
                            <label>About</label>
                            <textarea name="about"
                                      class="form-control"
                                      rows="5"
                                      placeholder="Enter something about yourself">Hey I am using TechBlog</textarea>
                        </div>

                        <!-- Checkbox -->
                        <div class="form-check mt-3">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="check"
                                   required>

                            <label class="form-check-label">
                                I confirm that all details are correct
                            </label>
                        </div>

                    </div>

                    <!-- Card Footer -->
                    <div class="card-footer text-center">

                        <!-- Loader -->
                        <div class="container text-center"
                             id="loader"
                             style="display: none;">

                            <span class="fa-solid fa-arrows-rotate fa-spin fa-3x"></span>
                            <h4>Please wait...</h4>
                            <br>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit"
                                id="submit-btn"
                                class="btn btn-success">
                            Register
                        </button>

                    </div>

                </form>
                <!-- Form End -->

            </div>

        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function () {

        console.log("loaded...");

        $('#reg-form').on('submit', function (event) {
            event.preventDefault();

            let form = new FormData(this);

            // Hide button, show loader
            $("#submit-btn").hide();
            $("#loader").show();

            $.ajax({
                url: "RegisterServlet",
                type: "POST",
                data: form,

                processData: false,
                contentType: false,

                success: function (data, textStatus, jqXHR) {

                    $("#submit-btn").show();
                    $("#loader").hide();

                    if (data.trim() === "done") {

                        swal(
                            "Registration Successful!",
                            "Your account has been created successfully. Redirecting to login page...",
                            "success"
                        ).then((value) => {
                            window.location = "login_page.jsp";
                        });

                    } else {

                        swal(
                            "Registration Failed!",
                            "Please check your details and try again.",
                            "error"
                        );
                    }
                },

                error: function (jqXHR, textStatus, errorThrown) {

                    $("#submit-btn").show();
                    $("#loader").hide();

                    swal(
                        "Server Error!",
                        "Something went wrong while processing your registration.",
                        "error"
                    );

                    console.log(jqXHR);
                }
            });

        });

    });
</script>

</body>
</html>