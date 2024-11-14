<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload your FASTA file</title>
</head>	
<h1 style="text-align:center">DNA editor</h1>
<h2 style="text-align:center">Upload your FASTA file</h2>
<p> SBOL is a standardised language whose purpose is to standardise biological data
exchange. For human visualisation there exists glyphs so that biological data is
more readable, E.g:</p>

<img src="Images/promote.jpg" alt="promoter">Promoter
<img src="Images/operator.png" alt="operator">Operator
<img src="Images/terminator.png" alt="engineered-region">Terminator
<img src="Images/cds.png" alt="Operator">CDS (Coding Sequence)
<body>
<p><br></p>
<img src="Images/ExampleRdf.png" alt="Operator" style="float: right; margin-right: 300px;" width="300" height="200">


<p>However there exists a format that is machine readable, in this case this is a SBOL document in the RDF/XML format:
</p>

</body>
<p><br><br><br><br><br><br><br><br><br></p>
<body>



    The purpose of this web-page, is for you to upload a raw FASTA file, and select
    specific regions within the DNA and eventually output a SBOL document.
    Please make sure the uploaded FASTA file has just nucleotide sequences.
    And is formatted like:
</body>

<p>
>HS415030.dna  (19�028 bp)
</p>
<p>
gttaatattcttgaagagatggatttacatagtttgttagagttgggtacaaaacctactgctcctcatgttcg
</p>
<p>
taataagaaggtgatattattcgacacaaatcatcaggttagtatctgtaatcagataatagatgcaataaact
</p>
<p>
cagggattgatcttggagatcttctagaagggggtttgctgacattgtgtgttgaacactattataattccgac
</p>
<body>
There are 12 roles that the libSBOLj3 allows to select from.
</body>
<p>
These are:
CDS (Coding Sequence),
Effector,
Engineered Region,
Functional Compartment,
Gene,
mRNA,
Operator,
Physical Compartment,
Promoter,
TF and 
Terminator.
</p>
<body style="background-color:lightgreen">
    <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
        <table border="1">
            <tr>
             <td>Please upload your FASTA file:</td>
            <td><input type="file" name="fastaFile" accept=".fasta, .fna"/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Submit" /></td>
            </tr>
        </table>
    </form>
   
<body>

<h2>Instructions to use the tool successfully</h2>
<p>Use the drop down menu and decide which genetic role you want to select</p>
If uploaded successfully, the webpage should look like this:
<p>

<img src="Images/Dropdown.png" alt="Operator" width=600 height=400> 
</p>
<p>After selecting the range of your nucleotides, click SUBMIT </p>
<p>Keep doing this until your needed number of sequences is met</p>
<img src="Images/sidebar.png" alt="sidebar" width=200 height=200>
<p>Once completed click generate SBOL document</p> 

</body>
</body>
</html>
