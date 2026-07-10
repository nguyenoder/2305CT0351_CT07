<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Portal Quản Lý Môn Học</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div style="font-size: 3rem; margin-bottom: 1rem;"></div>
            <h1>Academic Hub</h1>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-top: 0.75rem;">Nền tảng quản lý học tập hiện đại</p>
            <p style="color: var(--accent); font-size: 0.8rem; margin-top: 0.5rem;">⚡ Đăng nhập để bắt đầu quản lý</p>
        </div>
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <div class="error-message" style="display: flex; align-items: center; gap: 0.5rem;">
                <span style="font-size: 1.25rem;"></span>
                <span><%= errorMessage %></span>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post" style="margin-top: 1.5rem;">
            <div class="form-group">
                <label for="username" style="display: flex; align-items: center; gap: 0.5rem;">
               
                    <span>Tên đăng nhập</span>
                </label>
                <input type="text" id="username" name="username" required placeholder="admin">
            </div>
            <div class="form-group">
                <label for="password" style="display: flex; align-items: center; gap: 0.5rem;">
                    
                    <span>Mật khẩu</span>
                </label>
                <input type="password" id="password" name="password" required placeholder="••••••••" onchange="checkPasswordStrength(this.value)">
                <div id="pwdStrength" style="margin-top: 0.5rem; font-size: 0.8rem; color: var(--text-muted); display: none;"></div>
            </div>
            <button type="submit" class="btn" style="margin-top: 1rem;"> Đăng nhập ngay</button>
        </form>
        
        <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border); text-align: center;">
            <p style="font-size: 0.8rem; color: var(--text-muted);">Demo: admin / admin</p>
        </div>
    </div>
    
    <script>
        function checkPasswordStrength(pwd) {
            const strength = document.getElementById('pwdStrength');
            if (pwd.length < 1) {
                strength.style.display = 'none';
                return;
            }
            strength.style.display = 'block';
            if (pwd.length < 6) {
                strength.innerHTML = ' Mật khẩu yếu';
                strength.style.color = '#f43f5e';
            } else if (pwd.length < 10) {
                strength.innerHTML = ' Mật khẩu vừa phải';
                strength.style.color = '#0ea5e9';
            } else {
                strength.innerHTML = '✅ Mật khẩu mạnh';
                strength.style.color = '#10b981';
            }
        }
    </script>
</body>
</html>
