<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>File Contents</title>
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
            /* Adjust the sidebar styling as needed */
        }
        .content-container {
            width: 80%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: white;
            /* Removed the margin:auto; to allow flexbox alignment */
        }
        #root { height: 500px; width: 100%; }
        #buttonContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 12.5px; /* Adjust the gap between buttons */
        }
        .btn-outline-primary {
            margin: 2px; /* Margin around buttons for spacing */
            padding: 10px 10px; /* Padding inside buttons */
            color: black; /* Text color */
            border: black; /* Border color */
            width: 37px; /*exactly 20 per row*/
            height:40px;
            text-align:center;
           
            /* Optional: you can set a min-width or fixed width for uniform button sizes */
        }
        /* Dynamic classes for different colors */
        .btn-highlighted-red { background-color: red; }
        .btn-highlighted-blue { background-color: blue; }
        .btn-highlighted-green { background-color: green; }
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
        <p>Learning</p>
        <p> Nucleotides: <span id="highlightedValues"></span></p>
        <p> RBS: <span id="submittedSequence"></span></p>
        <button onclick ="saveValues()" id=Submit> Submit</button>
        
        <script >
        let submittedSequence=[];
        
        function saveValues() {
            let submittedSequence = [];
            document.querySelectorAll('.btn-highlighted-red, .btn-highlighted-blue, .btn-highlighted-green').forEach(button => {
                submittedSequence.push(button.textContent);
            });
            console.log(submittedSequence);
            
            document.getElementById('submittedSequence').innerText = submittedSequence.join('');
        }
        	
        </script>
       
       
    </div>
    <div class="content-container"><h1 style="text-align:center;"> Biological DNA/RNA Selector:</h1>
        <div id="root"></div>
        <script>
            <% String fileContent = (String) request.getAttribute("fileContent"); %>
            createSeqVizViewer("root", "", "<%= fileContent %>", { height: "100%", width: "100%" });
            console.log('${str} $fileContent.length')
        </script>
        <div style="margin-bottom: 20px;">
            <label for="colorSelect">Select Highlight Colour:</label>
            <select id="colorSelect">
                <option value="btn-highlighted-red">RBS</option>
                <option value="btn-highlighted-blue">Blue</option>
                <option value="btn-highlighted-green">Green</option>
            </select>
        	
        	
        </div>
        
        <p>Please Select the "Type" of Sequence with the Appropriate SBOL  Notation</p>
        <div id="buttonContainer"></div>
        
        <script>
        	
            let firstSelected = null;
            let selectedColor = 'btn-highlighted-red';
            const colorSelect = document.getElementById('colorSelect');
            colorSelect.addEventListener('change', () => {
                selectedColor = colorSelect.value;
            });
            let fileContentString = "<%= fileContent %>";
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
                    let startHighlighting = false;
                    let highlightedValues = [];
                    allButtons.forEach(button => {
                        button.classList.remove('btn-highlighted-red', 'btn-highlighted-blue', 'btn-highlighted-green');
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