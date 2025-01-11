<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Biological sequence Editor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: palegoldenrod; }
        .flex-container {
            display: flex;
            flex-direction: row;
        }
        .sidebar {
            width: 20%;
            padding: 20px;
        }
        .content-container {
            width: 80%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: white;
        }
        #root { height: 500px; width: 100%; }
        #buttonContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 12.5px;
        }
        .btn-outline-primary {
            margin: 2px;
            padding: 10px 10px;
            color: black;
            border: black;
            width: 37px;
            height: 40px;
            text-align: center;
        }
        .btn-highlighted-red { background-color: red; }
        .btn-highlighted-teal{ background-color: teal; }
        .btn-highlighted-olive { background-color: olive; }
        .btn-highlighted-violet {background-color: violet;}
        .btn-highlighted-purple {background-color: purple;}
        .btn-highlighted-yellow {background-color:yellow;}
        .btn-highlighted-pink {background-color:pink;}
        .btn-highlighted-navy{background-color:navy;}
        .btn-highlighted-turquoise{background-color:turquoise;}
        .btn-highlighted-blue{background-color:blue;}
        .btn-highlighted-maroon{background-color:maroon;}
        .btn-highlighted-plum{background-color:plum;}
        .btn-highlighted-lavender{background-color:lavender;}
    </style>
      <script src="https://unpkg.com/seqviz"></script>
    <script>
        function createSeqVizViewer(containerId, name, sequence, style) {
            if (window.seqviz && typeof window.seqviz.Viewer === 'function') {
                window.seqviz.Viewer(containerId, {
                    name: name,
                    seq: sequence,
                    style: style
                }).render();
            } else {
                console.error('SeqViz library is not working:(');
            }
        
        
        }
    </script>
    
    
    
</head>
<body>
<div class="flex-container">
    <div class="sidebar">
        
        <p>Nucleotides: <span id="highlightedValues"></span></p>
        <button onclick="saveValues()">Save current Nucleotides</button>
       
        
        <form action="RoleAllocationServlet" method="post" >
            <input type="hidden" name="allSequences" id="allSequences" >
            <p>Click the button below to send all the selected sequence(s) to make a SBOL file</p>
            <button type="submit">Generate a SBOL file</button>
        </form>
        <script>
            var allSequences = [];
            function saveValues() {
                let submittedSequence = [];
                document.querySelectorAll('.btn-highlighted-red, .btn-highlighted-teal, .btn-highlighted-olive, .btn-highlighted-violet, .btn-highlighted-purple, .btn-highlighted-yellow, .btn-highlighted-pink, .btn-highlighted-navy, .btn-highlighted-turquoise, .btn-highlighted-blue, .btn-highlighted-maroon, .btn-highlighted-plum, .btn-highlighted-lavender').forEach(button => {
                    submittedSequence.push(button.textContent);
                });
                let selectedOptionText = document.querySelector('#colorSelect option:checked').text;
                let sequenceDetail = selectedOptionText + " Sequence: " + submittedSequence.join("");
                allSequences.push(sequenceDetail);
                var newParagraph = document.createElement('p');
                newParagraph.textContent = sequenceDetail;
                document.querySelector('.sidebar').appendChild(newParagraph);
                document.getElementById('allSequences').value = JSON.stringify(allSequences);
                document.getElementById('submittedSequence').innerText = submittedSequence.join(''); // Displaying the latest submitted sequence
            }
            
            
        </script>
    </div>
    <div class="content-container">
        <h1 style="text-align:center;">Biological Editor of File: <%= request.getAttribute("firstLine") %></h1>
        <div id="root"></div>
        <script>
            <% String fileContent = (String) request.getAttribute("fileContent"); %>
            createSeqVizViewer("root", "", "<%= fileContent %>");
        </script>
        <div style="margin-bottom: 20px;">
            <label for="colorSelect">Select the range of DNA corresponding to a portion of DNA/RNA's role:</label>
            <select id="colorSelect">
                <option value="btn-highlighted-red">CDS</option>
                <option value="btn-highlighted-teal">Effector</option>
                <option value="btn-highlighted-olive">Engineered Gene</option>
                <option value="btn-highlighted-violet">Engineered Region</option>
                <option value="btn-highlighted-purple">Functional Compartment</option>
                <option value="btn-highlighted-yellow">Gene</option>
                <option value="btn-highlighted-pink">mRNA</option>
                <option value="btn-highlighted-navy">Operator</option>
            	<option value="btn-highlighted-turquoise">Physical Compartment</option>
            	 <option value="btn-highlighted-blue">Promoter</option> 
            	<option value="btn-highlighted-maroon">RBS</option>
            	<option value="btn-highlighted-plum">Terminator</option>
            	<option value="btn-highlighted-lavender">TF</option>
            </select>
        </div>
        <p>PLEASE SELECT THE FIRST NUCLEOTIDE WHERE YOUR NEEDED SEQUENCE BEGINS AND THE LAST NUCLEOTIDE WHERE IT ENDS:</p>
        <div id="buttonContainer"></div>
        <script>
            let firstSelected = null;
            let selectedColor = 'btn-highlighted-red';
            const colorSelect = document.getElementById('colorSelect');
            colorSelect.addEventListener('change', () => {
                selectedColor = colorSelect.value;
            });
            <% String FileContent = (String) request.getAttribute("fileContent"); %>
            let fileContentString = "<%= FileContent %>";
            let letters = fileContentString.split("");
            const buttonContainer = document.getElementById('buttonContainer');
            letters.forEach((letter, index) => {
                const button = document.createElement('button');
                button.type = "button";
                button.id = `button${index + 1}`;
                button.className = "btn btn-outline-primary";
                button.textContent = letter;
                button.addEventListener('click', handleButtonClick);
                buttonContainer.appendChild(button);
            });
            function updateHighlightedValues(text) {
                document.getElementById('highlightedValues').innerText = text;
            }
            function handleButtonClick(event) {
                if (!firstSelected) {
                    firstSelected = event.target;
                    firstSelected.classList.add(selectedColor);
                } else {
                    let secondSelected = event.target;
                    if (firstSelected === secondSelected) {
                        firstSelected.classList.remove(selectedColor);
                        firstSelected = null;
                        return;
                    }
                    let allButtons = document.querySelectorAll('#buttonContainer button');
                    let startHighlighting = false; //WHY ISNT THIS WORKING
                    let highlightedValues = [];
                    allButtons.forEach(button => {
                        button.classList.remove('btn-highlighted-red', 'btn-highlighted-teal', 'btn-highlighted-olive', 'btn-highlighted-violet', 'btn-highlighted-purple', 'btn-highlighted-yellow', 'btn-highlighted-pink', 'btn-highlighted-navy', 'btn-highlighted-turquoise', 'btn-highlighted-blue', 'btn-highlighted-maroon', 'btn-highlighted-plum', 'btn-highlighted-lavender');
                        if (button === firstSelected || button === secondSelected) {
                            startHighlighting = !startHighlighting;
                            button.classList.add(selectedColor);
                            highlightedValues.push(button.textContent);
                        } else if (startHighlighting) {
                            button.classList.add(selectedColor);
                            highlightedValues.push(button.textContent);
                        }
                    });
                    updateHighlightedValues(highlightedValues.join(''));
                    firstSelected = null;
                }
            }
        </script>
    </div>
    
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>