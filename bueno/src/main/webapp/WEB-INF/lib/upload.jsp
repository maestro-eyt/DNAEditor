<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload your FASTA file</title>
</head>	
<body>
    <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
        <table border="1">
            <tr>
                <td>Please upload your FASTA file:</td>
                <td><input type="file" name="fastaFile" accept=".fasta" /></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Submit" /></td>
            </tr>
        </table>
    </form>
    <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
    <table border="">
        <tr>
            <td>Please upload your SBOL file:</td>
            <td><input type="file" name="sbolFile" accept=".xml,.rdf,.ttl" /></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Submit" /></td>
        </tr>
    </table>
</form>
    
</body>
</html>
