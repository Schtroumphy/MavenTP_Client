<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link rel="stylesheet" href="css/style.css">
<title>Editer une ville</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
</head>
<body>
	<h1>Editer la ville sélectionée </h1> <br> <br>
	Nom de la ville récupérée :  <span id="villeNom"></span> <br>
	
	<div class="css/style">
	<form>
	<fieldset>
	<legend> <span class="number">1 | </span>Nouveau nom :</legend>
		 <input id="edtVille" type="text" name="newName" placeholder="Nom ville" required="required"/>  </br> 
		 
	<legend> <span class="number">2 | </span>Code postal</legend>
		 <input id="edtCode" type="number" name="codePostal"/>  </br> 
	</fieldset>
	
		<input type="button" onClick="edit();" value="Valider" />
	</form>
	
	Result : <span id="result"></span>
	
	</div>
<script type="text/javascript">
	document.getElementById("villeNom").textContent = sessionStorage.getItem("villeNom");
	//alert(" Ville récupérée : "+ sessionStorage.getItem("villeNom"))	;
	function edit(){
		console.log("Dans edit()");
		var villeToEdit = sessionStorage.getItem("villeNom");
		console.log("villeToEdit : "+ villeToEdit);
		var nouveauNom = document.getElementById("edtVille").value;
		console.log("nouveauNom : "+ nouveauNom);
		var newCodePostal = document.getElementById("edtCode").value;
		console.log("New CodePostal : "+ newCodePostal);
		
		var tab=[];
	 	
	 	var request = new XMLHttpRequest()
	 	var stringPut = 'http://localhost:8181/put?nomCommune='+ villeToEdit +'&nouveauNom='+ nouveauNom +'&codePostal='+ newCodePostal;
	 	alert(stringPut);
	 	request.open('PUT', stringPut, true);
	 	request.setRequestHeader("Access-Control-Allow-Headers", "Access-Control-Allow-Headers,Origin,Content-Type,Accept");
	 	request.setRequestHeader("Access-Control-Allow-Origin", "*");
	 	request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	 	console.log('http://localhost:8181/put?nomCommune='+ villeToEdit +'&nouveauNom='+ nouveauNom +'&codePostal='+ newCodePostal);
	 	request.onload = function() {
	 	  // Begin accessing JSON data here
	 	  var data = JSON.parse(this.response);

	 	  if (request.status >= 200 && request.status < 400) {
	 	     data.forEach(reponse => {
	 	      console.log(reponse.result)
	 	      console.log(reponse.message)
	 	     document.getElementById("result").textContent = reponse.message;
	 	      
	 	     setTimeout(function(){
	 	    	document.location.href="index.jsp";
				}, 3000);
	 	    })
	 	  } else {
	 	    console.log('error');
	 	  }
	 	  
	 	 console.log("Request status : "+ request.status);
	 	}

	 	request.send();
	 	
	}
</script>
</body>
</html>