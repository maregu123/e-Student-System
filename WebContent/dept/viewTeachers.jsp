<%
	String depID = (String) session.getAttribute("deptID");
	String depDep = (String) session.getAttribute("deptDept");
	String depCol = (String) session.getAttribute("deptCollege");

	if (depID == null && depDep == null && depCol == null) {
		response.sendRedirect("../login.jsp?msg=Session has already Expired, Please Login Again.");
	}
%>
<%@page import="com.deptHeadDao.ManageTeacherDao"%>
<%@page import="com.model.Instructor"%>
<%@page import="java.util.List"%>
<jsp:include page="includes/mainheader.jsp"></jsp:include>
<br>
<jsp:include page="includes/leftMenu.jsp"></jsp:include>
<!-- This is the right panel -->
<div class="col-md-10">
	<%
		String deptID = (String) session.getAttribute("deptDept");
	%>
	<%
		int pageSize, noOfPages, onPage;

		pageSize = 4;
		noOfPages = (int) (Math.ceil((double) ManageTeacherDao.getRowCount(deptID) / pageSize));
	%>






	<h4>Teacher Details</h4>
	<hr>

	<a href="importTeachers.jsp" class="btn btn-info btn-sm">Import
		Teachers</a>
	<div style="float: right;">
		<form action="searchTeachers.jsp" method="post">
			<input type="text" name="searchTeacher" placeholder="Search by ID">
		</form>
	</div>
	<hr>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>Teahcer's ID</th>
				<th>Full Name</th>
				<th>Gender</th>
				<th>Address</th>
				<th>Department</th>
				<th>College ID</th>
				<th>Stream</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
				String pageNumber = request.getParameter("page");
				if (pageNumber == null) {
					onPage = 1;
				} else {
					try {
						onPage = Integer.parseInt(pageNumber);
					} catch (NumberFormatException e) {
						onPage = 1;
					}
				}

				ManageTeacherDao mtDao = new ManageTeacherDao();
				List<Instructor> instructors = mtDao.getAllInstructors(deptID, (onPage - 1) * pageSize, pageSize);
				for (Instructor inst : instructors) {
			%>
			<tr>
				<td><%=inst.getInstructorID()%></td>
				<td><%=inst.getFullName()%></td>
				<td><%=inst.getGender()%></td>
				<td><%=inst.getAddress()%></td>
				<td><%=inst.getDeptID()%></td>
				<td><%=inst.getCollegeID()%></td>
				<td><%=inst.getStreamID()%></td>
				<td><a
					href="deleteTeacher.jsp?idNo=<%=inst.getInstructorID()%>"
					class="btn btn-danger btn-sm"
					onclick="return confirm('Are you sure to delete?')">Delete</a></td>

			</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<a href="viewTeachers.jsp?page=<%=1%>" class="btn btn-info btn-sm">First</a>
	<%
		for (int i = 1; i <= noOfPages; i++) {
	%>
	<a href="viewTeachers.jsp?page=<%=i%>" class="btn btn-info btn-sm"><%=i%></a>
	<%
		}
	%>
	<a href="viewTeachers.jsp?page=<%=noOfPages%>"
		class="btn btn-info btn-sm">Last</a>
</div>
</div>
</div>
<jsp:include page="includes/footer.jsp"></jsp:include>