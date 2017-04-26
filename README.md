# Paper-Ruiz-2017  
Source code from Ruiz et al., (2017) NCOMMS-17-03244.

### Abstract
Broad-spectrum antibiotics are frequently prescribed to children. The period of early-childhood represents a time where the developing microbiota may be more sensitive to environmental perturbations, which thus might have long-lasting host consequences. We hypothesized that even a single early-life broad-spectrum antibiotic course at a therapeutic dose (PAT) leads to durable alterations in both the gut microbiota and host immunity. In C57BL/6 mice, a single early-life tylosin (macrolide) course markedly altered the intestinal microbiome, and affected specific intestinal T-cell populations and secretory IgA expression, but PAT-exposed adult dams had minimal immunologic alterations. No immunological effects were detected in PAT-exposed germ-free animals; indicating that observed activities are microbiota dependent. Transfer of PAT-perturbed microbiota led to delayed sIgA expression indicating that the altered microbiota is sufficient to transfer PAT-induced effects. PAT exposure had lasting and transferable effects on microbial community network topology. Together these results indicate the impact of a single therapeutic early-life antibiotic course altering the microbiota and modulating host immune phenotypes that persist long after exposure has ceased.


### Description
This repository is set up to reproduce the figures and analyses within the publication, **Ruiz et al**. It contains the necessary scripts and code usd to analyze the multi-omics datasets generated. It does not contain the raw sequencing data nor the scripts to process the data, but this information can be found with the **Data Availability** section within the publication. In addition, most to all of the figures were generated individually and then placed into a single figure, which is not included in this repository.

### Structure Summary
The data is structured according the experiment. Within the each experiment folder, a subfolder of omics' dataset and scripts are organized to accomodate the various data that was generated and different analyses performed. Below is a treeview of the folder arrangement along with a short summary of each experiment. Each analysis is made up of shell scripts, but may include more reproducible formats (Rmarkdown, IPython Notebooks).

| Experiment 	| Description                                                                    	|
|:----------:	|--------------------------------------------------------------------------------	|
| PulsePAT   	| Tylosin exposures of 1 or 3 pulses in early life C57BL/6 wild-type mice.       	|
| TransPAT   	| Transfer of tylosin-perturbed cecal contents in early life C57BL/6 wild-type mice |
| GF-PAT     	| A single tylosin exposure from day 5-10 of life in C57BL/6 germ-free or SPF mice. 	|

```
── Paper-Ruiz-2017/
│   └── PulsePAT/
│     └── 16S_OTU/
│     └── IgA_concentration/
│     └── RNAseq/
│     └── Nanostring/
│
│   └── TransPAT/
│     └── Temporary/holder/
│
│   └── GF-PAT/
│     └── Temporary/holder/

```


### Figure structure
| Figure 	        | Location                                                                    	  |
|:--------------:	|---------------------------------------------------------------------------------|
| Figure-1b   	  | PulsePAT/16S_OTU/   |
| Figure-1c     	| PulsePAT/16S_OTU/ 	|
| Figure-1d     	| PulsePAT/16S_OTU/ 	|
| Figure-1e     	| PulsePAT/16S_OTU/ 	|
|---------------	|--------------------------------------------------------------------------------	|
| Figure-2a     	| PulsePAT/Nanostring 	|
| Figure-2d     	| PulsePAT/IgA_concentration/ 	|
| Figure-2e     	| PulsePAT/IgA_concentration/ 	|
| Figure-2f     	| PulsePAT/RNAseq/ 	|
| Figure-2g     	| PulsePAT/RNAseq/  	|
|---------------	|--------------------------------------------------------------------------------	|
| Figure-3a     	| Temporary/holder 	|
| Figure-3b     	| Temporary/holder 	|
| Figure-3c     	| Temporary/holder 	|
| Figure-3d     	| Temporary/holder 	|
| Figure-3e     	| Temporary/holder 	|
| Figure-3f     	| Temporary/holder 	|
| Figure-3g     	| Temporary/holder 	|
| Figure-3h     	| Temporary/holder 	|
|---------------	|--------------------------------------------------------------------------------	|
| Figure-4a     	| Temporary/holder 	|
| Figure-4b     	| Temporary/holder	|
| Figure-4c     	| Temporary/holder 	|
| Figure-4d     	| Temporary/holder 	|
| Figure-4e     	| Temporary/holder	|
| Figure-4f     	| Temporary/holder 	|
| Figure-4g     	| Temporary/holder 	|
| Figure-3h     	| Temporary/holder 	|


