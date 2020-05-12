# FlutterSamples
This repository stores all flutter/dart code samples to be used within __Omega365__ documentation site.

# Adding new samples
It's recommended to clone __af.widgets.sampletemplate__ folder to use as a starting base for you sample.

 1. Create a folder for your sample and name it appropriately.
 2. Add at least a __main.dart__ file to your newly created folder. Below are all the files you can add:
    * __main.dart__ : The code to display — for example, a working or nonworking method.
    * __dartpad_metadata.yaml__ : a yaml metadata file with name, mode and files attributes described.
    * __test.dart__ (optional) : A main() function that tests the above code. Also contains any classes, functions, constants, etc. to be used by main.dart but not displayed.
    * __solution.dart__ (optional) : The ideal final state of main.dart, once the user has made all the changes you've asked them to make. The solution code is hidden until the user asks to see it.
    * __hint.txt__ (optional) : A text hint that the user can request to see, to help them complete the exercise. Examples: "Try X or Y," "Have you considered Z."

# Displaying your sample using DartPad
Use the snippet below, replace __[YOUR_SAMPLE_PATH]__ with your sample directory path in the repository.

`<iframe style="width:1000px;height:800px;" src="https://dartpad.dev/embed-flutter.html?gh_owner=Omega365&gh_repo=appframe-flutter-samples-public&gh_path=[YOUR_SAMPLE_PATH]&split=60"></iframe>`

* Optionally, you can append __&run=true__ if you want your sample to be automatically ran when the web-page loads.