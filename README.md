# Paper-Ruiz-2017  
Source code from:  
Ruiz VE, Battaglia T, Kurtz ZD, et al. A single early-in-life macrolide course has lasting effects on murine microbial network topology and immunity. **Nature Communications**. 2017;8:518. doi:10.1038/s41467-017-00531-6.

### Abstract
Broad-spectrum antibiotics are frequently prescribed to children. Early childhood represents a dynamic period for the intestinal microbial ecosystem, which is readily shaped by environmental cues; antibiotic-induced disruption of this sensitive community may have long-lasting host consequences. Here we demonstrate that a single pulsed macrolide antibiotic treatment (PAT) course early in life is sufficient to lead to durable alterations to the murine intestinal microbiota, ileal gene expression, specific intestinal T-cell populations, and secretory IgA expression. A PAT-perturbed microbial community is necessary for host effects and sufficient to transfer delayed secretory IgA expression. Additionally, early-life antibiotic exposure has lasting and transferable effects on microbial community network topology. Our results indicate that a single early-life macrolide course can alter the microbiota and modulate host immune phenotypes that persist long after exposure has ceased.

### Description
This repository is set up to reproduce the figures and analyses within the publication, **Ruiz et al**. It contains the necessary scripts and code usd to analyze the multi-omics datasets generated. It does not contain the raw sequencing data nor the scripts to process the data, but this information can be found with the **Data Availability** section within the publication. In addition, most to all of the figures were generated individually and then placed into a single figure, which is not included in this repository.

### Structure Summary
The data is structured according the experiment. Within the each experiment folder, a subfolder of omics' dataset and scripts are organized to accomodate the various data that was generated and different analyses performed. Below is a treeview of the folder arrangement along with a short summary of each experiment. Each analysis is made up of shell scripts, but may include more reproducible formats (Rmarkdown, IPython Notebooks).

| Experiment 	| Description                                                                    	|
|:----------:	|--------------------------------------------------------------------------------	|
| PulsePAT   	| The effect of a single or multiple pulsed antibiotic exposure in C57BL/6 mice.      	|
| TransPAT   	| Transfer of tylosin-perturbed cecal contents in early life C57BL/6 wild-type mice. |
| GF-PAT     	| The effect of early life antibiotic treatment in germ-free or SPF colonized C57BL/6 mice. 	|
| IgA-Seq     | 16S microbial composition of IgA-bound or IgA-unbound bacteria 	|

```
── Paper-Ruiz-2017/
│   └── PulsePAT/
│     └── 16S_OTU/
│     └── IgA_concentration/
│     └── RNAseq/
│     └── Nanostring/
│
│   └── TransPAT/
│     └── 16S_OTU/
│     └── IgA_concentration/
│
│   └── GF-PAT/
│     └── 16S_OTU/
│     └── IgA_concentration/
│     └── Physiology/
│     └── Nanostring/
│
│   └── IgA-Seq/
```


### Figure structure
| Figure 	        | Location                                                                    	  |
|:--------------:	|---------------------------------------------------------------------------------|
| Figure-1b   	  | PulsePAT/16S_OTU/   |
| Figure-1c     	| PulsePAT/16S_OTU/ 	|
| Figure-1d     	| PulsePAT/16S_OTU/ 	|
| Figure-1e     	| PulsePAT/16S_OTU/ 	|
|---------------	|--------------------------------------------------------------------------------	|
| Figure-2a     	| PulsePAT/Nanostring/ 	|
| Figure-2d     	| PulsePAT/IgA_concentration/ 	|
| Figure-2e     	| PulsePAT/IgA_concentration/ 	|
| Figure-2f     	| PulsePAT/RNAseq/ 	|
| Figure-2g     	| PulsePAT/RNAseq/  	|
|---------------	|--------------------------------------------------------------------------------	|
| Figure-3b     	| GF-PAT/16S_OTU/ 	|
| Figure-3c     	| GF-PAT/16S_OTU/ 	|
| Figure-3d     	| GF-PAT/Physiology/ 	|
| Figure-3e     	| GF-PAT/IgA_concentration/  	|
| Figure-3f     	| GF-PAT/Nanostring/ 	|
| Figure-3g     	| GF-PAT/Nanostring/ 	|
|---------------	|--------------------------------------------------------------------------------	|
| Figure-4b     	| TransPAT/IgA_concentration/	|
| Figure-4d     	| TransPAT/16S_OTU/	|
| Figure-4e     	| TransPAT/16S_OTU/	|
| Figure-4f     	| TransPAT/16S_OTU/ |
