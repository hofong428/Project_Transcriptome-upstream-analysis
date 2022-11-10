# Transcriptome-upstream-analysis
Transcriptome is the set of all RNA transcripts, including coding and noncoding, in an individual or a population of cells.
The original sequence obtained by sequencing contains adapter sequence or low-quality sequence, in order to ensure the information separation.
The accuracy of the analysis requires quality control of the original data to obtain high-quality sequences (i.e.
Clean Reads), the original sequence quality control standards are:
(1) Remove reads containing adapters;
(2) Filter out low-quality data to ensure data quality;
(3) Remove reads with a ratio of more than 5% containing N (base information cannot be determined);

RNA-seq technology appeared a decade ago, and since its inception, RNA-seq has become a ubiquitous tool for studying molecular biology, and this technology almost forms the basis of our knowledge of genome function. The most commonly used analysis method in RNA-seq is to find **Differential gene expression (DGE)**. The basic stages of DGE analysis have not changed substantially since the earliest published journals. In the laboratory, the standard process is divided into three steps:

The first step is to construct a sequencing library, which involves extracting RNA, enriching for mRNA or clearing ribosomal RNA, synthesizing cDNA, and adding adapters.

In the second step, the library is sequenced on a high-throughput platform (usually the Illumina platform), and the sequencing depth of each sample is 10-30M reads (read lengths are the reads mentioned above).

The third step is data analysis. The specific work is: aligning and/or assembling the reads obtained by sequencing into the transcriptome, filtering these reads covering the transcriptome, and classifying them into the transcriptome. Normalization (Normalization), according to the statistical model to find those transcripts that are different between different samples. Early RNA-seq generated DGE data from a large number of experimental samples, illustrating the use of RNA-seq in a wide range of organisms and systems, including maize (Zea mays), Arabidopsis thaliana (Arabidopsis thaliana) ), Saccharomyces cerevisae, mice (Mus musculus) and humans. Although the term RNA-seq is often used for those with disparate methodological approaches and/or biology, DGE analysis is still the main application of RNA-seq (Table 1 in Supplementary Materials) and is considered a routine research tool .

The wider application of RNA-seq has advanced our understanding of many aspects of biology, such as by suggesting mRNA splicing and regulation of gene expression by noncoding and enhancer RNAs. The application and advancement of RNA-seq is driven by technological developments (wet lab and computational biology), which yields richer and less biased insights into RNA biology and transcriptome than previous gene chips Information. So far, there are almost 100 various RNA-seq methods derived from standard RNA-seq methods. Illumina's short-read sequencing platform can sequence these libraries constructed by RNA-seq of most different methods, but more recently long-read RNA-seq and direct RNA-seq sequencing Advances in direct RNA sequencing (dRNA-seq) have been able to address some of the problems previously unsolved by researchers using short-sequence approaches.
