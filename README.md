#Artefact: Security Summary Inference for Java Programs

This artefact contains our experiments on specification inference for Java (bytecode) programs. It includes the tool (binary version), along with input to reproduce experiments for precision and scalability analyses.

## Contents

- Usr Study: The Microsoft form of questions as well as the results for the user study
- Experiments/IFSPEC:
	* The comparison results are available in the IFSPEC_MAIN-HeapDomainsExperiments.xlsx
	* The Results folder contains the test cases as well as our tool output --- it is in the nice folder of the test cases.
	* The source code and the results for Joana/Key/Cassandra are in the original IFSPEC Benchmark 

- Experiments/7194/files contains our results for Java API and real-life applications 
	* `syrs.opt` and its dependancies: The binary of our tool.
	* `Syrsworks/JavaAPI-V3/`: Experiments on the Java SDK for precision/scalability analysis.
	* `Syrsworks/Real-life Applications/`: Experiments on open-source Java applications for scalability analysis.
	* 'Syrsworks/secstubs.xlsx' shows the AI command used to generate security stubs and the list of security stubs generated. Note that the tool by default constructs a security summary, and use these security stubs, if it fails to analyze a method or a method is excluded from analysis by the user, e.g., it's a native code.

---

Each experiment folder in Java API or Real-life Applications contains:
	- Compiled application binaries or their source codes,
	- Input data generated from `.jar` files for our tool,
	- The tool output.

## Folder structure of the tool output

In each application subfolder for the tool output, the following structure is used:

| Folder/File           | Description                                                                |
|-----------------------|----------------------------------------------------------------------------|
| `Meth/`               | Contains one `.meth` file per method.                                      |
| `types.classes`       | Contains class definitions used in the analysis.                           |
| `Meth/all.secstubs`   | Optional security summaries for methods excluded from inference.           |
| `Meth/all.meths_files`| List of methods selected for analysis.                                     |
| `*.secsums`           | Security summaries inferred by the tool.                                   |
| `.meth_stats`         | Statistics generated for the analysis.                                     |

---

## Runing the Experiments

### 1. Setup Environment

From the main directory (`Artefact/Experiments`), run:

`bash source 7194/files/setup.sh`

This sets up necessary environment variables and dependencies.

---

### 2. Run Java API (Precision) Experiments

Execute the following script:

`bash 7194/files/RunAllJavaAPI.bash`

This will run the experiments in the `JavaAPI-V3/` folder.

---

### 3. Run Scalability Experiments

Execute the following script:

`bash 7194/files/RunAll.bash`

This runs the experiments in the `Real-life Applications/` folder.

---

## Output

After running the experiments, the following key outputs will be generated:

* `*.secsums`: Security summaries inferred for the analyzed methods.
* `.meth_stats`: Contains statistics such as analysis time, statistics about each method, number of skipped methods and the cause, etc.

We also provide a set of analysis reports for the Java API experiments, which can be found in the 'JavaAPI-V3/Reports' folder.
