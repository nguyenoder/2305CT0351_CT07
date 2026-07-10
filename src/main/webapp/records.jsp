<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Quản lý Môn Học - Academic Hub</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="align-items: flex-start; padding-top: 2rem;">
    <div class="dashboard">
        <div class="dashboard-header">
            <div>
                <h1 style="display: flex; align-items: center; gap: 0.75rem;">
                
                    <span>Bảng Điều Khiển Học Tập</span>
                </h1>
                <p style="color: var(--text-muted); margin-top: 0.75rem; font-size: 0.95rem;">
                     Xin chào, <strong style="color: var(--accent);">${sessionScope.user.username}</strong> | Quản lý các khóa học của bạn
                </p>
            </div>
            <div style="display: flex; gap: 1rem;">
                <button class="btn btn-success" onclick="openModal('addModal')" style="display: flex; align-items: center; gap: 0.5rem; justify-content: center;">
                
                    <span>Thêm Khóa</span>
                </button>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger" style="text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; justify-content: center;">
                   
                    <span>Thoát</span>
                </a>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
            <div class="stat-card">
                <div style="font-size: 2rem; margin-bottom: 0.5rem;"></div>
                <div style="font-size: 0.8rem; color: var(--text-muted);">Tổng Khóa Học</div>
                <div style="font-size: 1.75rem; color: var(--accent); font-weight: 700;">
                    <c:if test="${records != null}">${records.size()}</c:if>
                    <c:if test="${records == null}">0</c:if>
                </div>
            </div>
            <div class="stat-card">
                <div style="font-size: 2rem; margin-bottom: 0.5rem;"></div>
                <div style="font-size: 0.8rem; color: var(--text-muted);">Tổng Chi Phí</div>
                <div style="font-size: 1.75rem; color: #10b981; font-weight: 700;">
                    <c:set var="total" value="0"/>
                    <c:if test="${records != null}">
                        <c:forEach var="r" items="${records}">
                            <c:set var="total" value="${total + r.fee}"/>
                        </c:forEach>
                    </c:if>
                    $${total}
                </div>
            </div>
            <div class="stat-card">
                <div style="font-size: 2rem; margin-bottom: 0.5rem;"></div>
                <div style="font-size: 0.8rem; color: var(--text-muted);">Trạng Thái</div>
                <div style="font-size: 1.75rem; color: #0ea5e9; font-weight: 700;">Hoạt Động ✓</div>
            </div>
        </div>

        <div class="card">
            <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.5rem;">
                <span style="font-size: 1.5rem;"></span>
                <h2 style="margin: 0; color: var(--text-main);">Danh Sách Khóa Học</h2>
            </div>
            <table>
                <thead>
                    <tr>
                        <th style="text-align: center;"></th>
                        <th> Tên Sinh Viên</th>
                        <th> Khóa Học</th>
                        <th style="text-align: right;"> Học Phí</th>
                        <th style="text-align: center;"> Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${records}">
                        <tr>
                            <td style="text-align: center; font-weight: 600; color: var(--accent);">${r.id}</td>
                            <td><span style="font-weight: 500;">${r.stname}</span></td>
                            <td><span style="background: rgba(6, 182, 212, 0.2); padding: 0.3rem 0.7rem; border-radius: 0.4rem; font-size: 0.85rem;">${r.course}</span></td>
                            <td style="text-align: right; font-weight: 600; color: #10b981;">$${r.fee}</td>
                            <td class="action-btns" style="text-align: center;">
                                <button class="btn btn-sm" style="background: var(--primary); width: auto; padding: 0.4rem 0.8rem;" 
                                        onclick="openEditModal(${r.id}, '${r.stname}', '${r.course}', ${r.fee})">✏️ Sửa</button>
                                <form action="${pageContext.request.contextPath}/records" method="post" style="display: inline;" onsubmit="return confirm('Bạn chắc chắn muốn xóa khóa học này?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${r.id}">
                                    <button type="submit" class="btn btn-danger btn-sm" style="width: auto; padding: 0.4rem 0.8rem;">🗑️ Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty records}">
                        <tr>
                            <td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2rem;">
                                <div style="font-size: 2rem; margin-bottom: 0.5rem;"></div>
                                <div>Chưa có khóa học nào. <strong style="color: var(--accent);">Thêm khóa học đầu tiên của bạn!</strong></div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Add -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 style="display: flex; align-items: center; gap: 0.5rem;">
                
                    <span>Thêm Khóa Học Mới</span>
                </h2>
                <span class="close" onclick="closeModal('addModal')" style="font-size: 1.75rem;">&times;</span>
            </div>
            <form action="${pageContext.request.contextPath}/records" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                    
                        <span>Tên Sinh Viên</span>
                    </label>
                    <input type="text" name="stname" placeholder="Nhập tên sinh viên" required>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                        <span>📖</span>
                        <span>Khóa Học</span>
                    </label>
                    <input type="text" name="course" placeholder="VD: JavaScript 101" required>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                        
                        <span>Học Phí</span>
                    </label>
                    <input type="number" name="fee" placeholder="Nhập số tiền" required min="0">
                </div>
                <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                    <button type="submit" class="btn btn-success" style="flex: 1;"> Lưu Khóa Học</button>
                    <button type="button" class="btn" style="flex: 1; background: var(--border); color: var(--text-main);" onclick="closeModal('addModal')">❌ Hủy</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal Edit -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 style="display: flex; align-items: center; gap: 0.5rem;">
                    
                    <span>Cập Nhật Khóa Học</span>
                </h2>
                <span class="close" onclick="closeModal('editModal')" style="font-size: 1.75rem;">&times;</span>
            </div>
            <form action="${pageContext.request.contextPath}/records" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="edit-id">
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                    
                        <span>Tên Sinh Viên</span>
                    </label>
                    <input type="text" name="stname" id="edit-stname" required>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                        <span>📖</span>
                        <span>Khóa Học</span>
                    </label>
                    <input type="text" name="course" id="edit-course" required>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 0.5rem;">
                       
                        <span>Học Phí</span>
                    </label>
                    <input type="number" name="fee" id="edit-fee" required min="0">
                </div>
                <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                    <button type="submit" class="btn" style="flex: 1; background: var(--primary);"> Cập Nhật</button>
                    <button type="button" class="btn" style="flex: 1; background: var(--border); color: var(--text-main);" onclick="closeModal('editModal')">❌ Hủy</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal(id) {
            document.getElementById(id).classList.add('active');
        }
        function closeModal(id) {
            document.getElementById(id).classList.remove('active');
        }
        function openEditModal(id, stname, course, fee) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-stname').value = stname;
            document.getElementById('edit-course').value = course;
            document.getElementById('edit-fee').value = fee;
            openModal('editModal');
        }

        // Đóng modal khi click ra ngoài
        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('active');
            }
        }
    </script>
</body>
</html>
