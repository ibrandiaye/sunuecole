<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | SunuEcole Digital</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4cc9f0;
            --dark: #2b2d42;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .auth-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 450px;
            padding: 40px;
            position: relative;
            z-index: 2;
        }

        .brand-icon {
            width: 60px;
            height: 60px;
            background: var(--primary);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 32px;
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }

        .form-control {
            border-radius: 12px;
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            background: #fdfdfd;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
            border-color: var(--primary);
        }

        .btn-login {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 700;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.2);
        }

        .btn-login:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(67, 97, 238, 0.3);
        }

        .bg-decor {
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(67, 97, 238, 0.1) 0%, transparent 70%);
            z-index: 1;
            top: -250px;
            right: -250px;
        }

        .bg-decor-2 {
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(76, 201, 240, 0.1) 0%, transparent 70%);
            z-index: 1;
            bottom: -200px;
            left: -200px;
        }
    </style>
</head>
<body>
    <div class="bg-decor"></div>
    <div class="bg-decor-2"></div>

    <div class="auth-card animate__animated animate__zoomIn">
        <div class="brand-icon">
            <i class='bx bxs-graduation'></i>
        </div>
        <h3 class="text-center fw-bold mb-1">SunuEcole Digital</h3>
        <p class="text-center text-muted small mb-4">Connectez-vous pour accéder à votre espace</p>

        @if($errors->any())
            <div class="alert alert-danger border-0 rounded-3 small">
                {{ $errors->first() }}
            </div>
        @endif

        <form action="{{ route('login.post') }}" method="POST">
            @csrf
            <div class="mb-3">
                <label class="form-label small fw-bold">ADRESSE EMAIL</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class='bx bx-envelope text-muted'></i></span>
                    <input type="email" name="email" class="form-control" placeholder="nom@exemple.com" required autofocus>
                </div>
            </div>

            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <label class="form-label small fw-bold">MOT DE PASSE</label>
                    <a href="#" class="text-primary small text-decoration-none fw-semibold">Oublié ?</a>
                </div>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class='bx bx-lock-alt text-muted'></i></span>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember" name="remember">
                <label class="form-check-label small text-muted" for="remember">Rester connecté</label>
            </div>

            <button type="submit" class="btn-login">SE CONNECTER</button>
        </form>

        <div class="text-center mt-4">
            <p class="small text-muted">© 2026 SunuEcole Digital - Tous droits réservés.</p>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
