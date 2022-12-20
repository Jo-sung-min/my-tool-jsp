<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signupForm</title>
<link href="style.css" rel="stylesheet" type="text/css"/>


		<script >
			// 유효성 검사
			function checkField(){
				let inputs = document.inputForm;
				if(!inputs.id.value){//name 속성이 id인 요소의 value가 없으면 true
					alert("아이디를 입력하세요");
					return false;// submit의 기본 기능인 action 에 지정한 pro 페이지로 이동하는 기능을 막겠다.
				}
				if(!inputs.pw.value){
					alert("비밀번호를 입력하세요");
					return false;
				}
				if(!inputs.pwch.value){
					alert("비밀번호확인란를 입력하세요");
					return false;
				}
				if(!inputs.name.value){
					alert("이름을 입력하세요");
					return false;
				}
				if(inputs.pw.value!=inputs.pwch.value){
					alert("비밀번호가 서로 다릅니다.")
					return false;
				}
				
			}
			
			function openConfirmId(inputForm) {
		         // 사용자가 id 입력란에 작성을 했는지 체크 
		         if(inputForm.id.value == ""){
		            alert("아이디를 입력하세요.");
		            return;    // 이 함수 강제 종료 
		         }
		         // 아이디 중복 검사 팝업 열기 
		         let url = "confirmId.jsp?id=" + inputForm.id.value;         
		         open(url, "confirmId", "width=300, height=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no"); 
		      }
			
		</script>

</head>

<body>
<h1 align="center">회원가입</h1>

<form action="signupPro.jsp" method="post" name="inputForm" onsubmit="return checkField()" >
	<table>
		<tr>
			<td>아이디*</td>
			<td><input type="text" name="id"/></td>
		</tr>
		<tr>
		<tr>
			<td>아이디중복확인</td>
			<td><input type="button" value="아이디중복확인" onclick="openConfirmId(this.form)"/></td>
		</tr>
		<tr>
			<td>비밀번호*</td>
			<td><input type="password" name="pw"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인*</td>
			<td><input type="password" name="pwch"/></td>
		</tr>
		<tr>
			<td>이름 *</td>
			<td><input type="text" name="name"/></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
			<input type="radio" name="gender" value="male" checked/>남 <br/>
			<input type="radio" name="gender" value="female"/>여 <br/>
			</td>
		</tr>
		<tr>
			<td>email</td>
			<td><input type="text" name="email"/></td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="submit" value="회원가입"/>
			<input type="reset" value="재작성"/>
			<input type="button" value="취소" onclick="window.location='main.jsp'"/>
			</td>
		</tr>
	</table>	







</form>



</body>
</html>