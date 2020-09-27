---
title: Survey on Security and Privacy of Machine Learning
date: 2018-07-18T09:10:00+08:00
draft: false
tags: ['Tech', 'Papers']
categories: ['Papers']
author: Kaiya Xiong
autoCollapseToc: true
summary: Survey on Security and Privacy of Machine Learning
---
## Survey on Security and Privacy of Machine Learning
* TOC
{:toc}
### Abstract
> ML was used in image processing, natural language processing, pattern recognition, cybersecurity and other fields.

And Scenarios: facial recognition, malware detection, automatic driving, and intrusion detection.
But these algorithms and corresponding training data are vulnerable.

> Academia and industry have found out many security threats against a variety of learning algorithms, including naive Bayes, logistic regression, decision tree, support vector machine (SVM), principle component analysis, clustering, and prevailing deep neural networks.

Survey from two aspects: the training phase and the testing/inferring phase.

defensive techniques, four groups:

* security assessment mechanisms
* countermeasures in the training phase
* countermeasures in the testing or inferring phase
* data security, and privacy

### 1. Introduction

### 2. Basic Concept, Model, Taxonomy
#### 1. Basic of Machine Learning
According to differences of feedbacks, machine learning related works can be categorized into three groups:
* supervised learning: decision tree, support vector machine (SVM), neural networks, etc.
* unsupervised learning: Clustering and auto-encoder.
* reinforcement learning: optimizes behavior strategies via try-and-error.

#### 2. Adversarial Model

Biggio *et al.* argued that well-deﬁned adversarial model should be constructed with four dimensions, goal, knowledge, capability and attacking strategy. 

1. Goal: can be clearly described using both the expected impacts and the attack speciﬁcity of security threats.
2. Knowlodge: divided into two groups named **constrained knowledge** and **complete knowledge** by examining whether or not an attacker know training data, features, learning algorithms, decision functions, classiﬁer parameters and feedback information.
3. Capability: qualitative interpreted from three aspects: (1) Is the impact of security threats causative or exploratory? (2) What is the percentage of training and testing data that are controlled by the attacker? (3) What is the extent of features and parameters that are known by the attacker?
4. Attacking strategy: speciﬁc behaviors of manipulating training and testing data to effectively achieve his/her goals.

#### 3. Security threats taxonomy

##### 1. Influence on classifiers

* Causative Attack: adversaries change the distri of training data, which induces param chagnes of learning models when retraining.
* Exploratory attack: does not modify already trained classifiers, but aims to cause misclassification with respect to adversarial samples or to uncover sensitive info.

##### 2. Security violation

* Integrity attack: try to increase the **false negatives** of existing classifiers when classifying harmful samples.
* Availability attack: on the contrary, increase the **false positives** of classifiers with respect to benign samples.
* Privacy violation attack: able to obtain sensitive and confidential info.

##### 3. Attack specificity 

* Targeted attack: highly directed to reduce the performance of classifiers on one particular sample or one specific group of samples.
* Indiscriminate attack: causes the classifiers to fail in an indiscriminate fashion on a broad range of samples.

![taxonomy of security threats](https://lib.azfs.com.cn/2018-07-15-084523.png)

### 3. Security Threats towards machine learning

An attacker can inject malicious and designated data into training data during the training procedure of machine learning based intrusion detection systems, inducing a significant decrease of the performance of these systems.

**Clustering**  is a kind of unsupervised learning method, which can discover implicit patterns of data distributions. Most of attacks against clustering algorithms reduce their accuracy by injecting malicious data. **Obfuscation attack** is another type of threat that compromises clustering algorithms. It's goal against the targeted cluster is to generate a blend of adversarial samples and normal ones from other clusters without altering the clustering results of these normal samples, resulting in a set of stealthy adversarial samples.

**Deep Learning** : as a typical arch of dl, DNN is demonstrated to be effective in various pattern recognition tasks. DNN is also vulnerable to various adversarial attacks. In image classification, DNN only extracts a small set of features, resulting in poor performance on the images with minor differences. Potential adversaries can exploit such vulnerability to evade anomaly detection. In 2013, Szegedy *et al.* proposed to use the generated image with slight turbulence to deceive the pre-trained DNN.

#### 1. Training Phase

**Poisoning attack** : a type of causative attack, disrupts availability and integrity of models via injecting adversarial samples to the training data. Such adversarial samples are designated to have similar features with malicious samples but incorrect labels, including change of training data distribution. It's not easy to alter the data itself. So the adversaries exploit the vulnerability that stems from **retraining** existing machine learning models. Machine learning based systems are generally required to **periodically update** their decision models to adapt to varying application contexts. So the adversaries can utilize the periodic update characteristic. 

For unsupervised learning, e.g., clustering analysis, it's not applicable for changing the sample labels. However, some researches introduced how to launch poisoning attack against single-linkage and complete-linkage hierarchical clustering. For example, a heuristic strategy can be adopted to measure the impact induced by adversarial samples on clustering accuracy via introducing a *bridge* concept. Then the optimal adversarial samples were selected to effectively reduce the clustering accuracy. Three commonly used graph clustering or embedding techniques:

* Community discovery
* Singular value decomposition (SVD)
* Node2vec

There are two novel attacks, named **targeted noise injection** and **small community**. These attacks can effectively evade graph clustering approaches with limit adversaries knowledge and low cost. Two defense strategies: **Training Classifier with Noise** (similar to adversarial training) and **Improving hyper-parameter selection** , but the defense effect is not significant.

##### 1) Poisoning without modifying features or labels

adversarial samples selecting methods:

* poisoning models: selected according to the degree of performance reduction in terms of the classification accuracy of learning models over validating data sets. (Feasible on decision tree, nearest neighbor classifier, multilayer perception, and SVM)
* **gradient ascent strategy**: selected by calculating the gradient of objective functions that measure the effectiveness of adversarial samples. (Feasible on SVM, LASSO, PDF malware detection systems)
* **GAN**: generative model is trained to generate candidate adversarial samples. Then, the discriminative model is used to select the optimal samples with a specific loss function.

Comparative results between GAN and direct gradient methods on MNIST and CIFAR-10 data sets validated that GAN was able to rapidly generate high-quality adversarial samples with a large loss value.

##### 2) Poisoning with modifying features or lables

More powerful adversary model has the capability of modifying extracted features or the labels of some training data. 

> Transferring the problem of selecting target labels to an optimization one

* In **label contamination attack**(LCA), an attacker can significantly reduce the performance of SVM by **flipping the labels of some training data**.
* Xiao. *et al.* Extended the model to attack against some black-box linear learning such as SVM and logistic regression.

#### 2. Testing or Inferring Phase

Utilizing the trained model to classifying or clustering new data. The most common types of security threats against the testing/Inferring phase include `spoofing` (for example, `evasion` and `impersonate` threats) and `Inversion attack`.

**1) Evasion attack**: main idea is that an attacker generates some adversarial samples that are able to evade detection such that overall security of target systems is significantly reduced.

* Attack and Defense: generate the optimal adversarial samples to evade detection via gradient algorithms.
* Evasion attacks was feasible for use to attack against FRS and malware detection real world, resulting in severe security threats towards target systems.

**2) Impersonate attack**: **imitate data samples from victims**, use in image recognition, malware detection. Attacker aims to generate specific adversarial samples such that existing machine learning-based systems wrongly classify the original samples with different labels from the impersonated ones. Such attack is **particularly effective in attacking DNN algorithms** because *DNN usually extracts a small feature set to facilitate the object identification*. So, attacker can easily launch impersonate attacks by **modifying some key features**.

* Electrical world: Use a revised genetic algorithm called Multi-dimensional Archive of Phenotypic Elites(MAP-Elites), to generate the optimal adversarial samples after evolving images from different categories. Then, these samples were fed into AlexNet and Le-Net-5 network, resulting in the performance reduction of DNNs.
* Physical world: adversary generated electronic adversarial samples via the least likely class method. Then these adversarial images were printed out to serve as the input of camera. Due to the feature loss during printing and photography, the successful rate was much lower than that in electrical world. But it also validated the feasibility of impersonate attacks in real world.

More work show that ***`transferable`*** adversarial samples could be generated from `ensemble learning`, where the output samples from one DNN were effective for use to attack against other DNNs.

*Hidden voice commands* :

> Real experiments: the voice with no meanings in the perspective of human-beings could be used to emulate real voice control commands.

**3) Inversion attack** : utilizes the API provided by existing machine learning systems to gather some basic information regarding target system models. Then, the basic information is fed into **reverse analysis** followed by the leakage of privacy data embedded in target models.

According to the degree of understanding knowledge in adversarial models, this type of attack can be generally classified into two groups: namely **white-box attack** and **black-box attack**.

#### 3. Summary of Adversarial attacks against machine learning

![image-20180715224335752](https://lib.azfs.com.cn/2018-07-15-144336.png)
### 4. Defensive Techniques of Machine Learning

![image-20180715235824018](https://lib.azfs.com.cn/2018-07-15-155824.png)

#### 1. Security assessment mechanisms

Most of existing assessing techniques focus on quantitatively evaluating the performance of various learning algorithms rather than their security.
A designer first introduces adversarial assumptions towards classifer vulnerabilities. Then, the designer proposes countermeasures to protect classifiers from the adversaries. There are two types of defensive mechanisms, i.e., **proactive defense** and **reactive defense**, as illustrated in Fig. 4.
![image-20180715235759999](https://lib.azfs.com.cn/2018-07-15-155800.png)

The notable differences between proactive and reactive defending mechanisms include the following two aspects:

* The attacking and defending subjects are both the classifier designer in proactive defense.
* The designer only performs penetration testing to uncover vulnerabilities rather than a true attack against the classifier. In other words, penetration testing in the proactive defending mechanism and attacking in the reactive one are benign and malicious, respectively.

The distribution of training data and that of testing data will be notably different with the presence of adversarial samples. Such abnormal phenomenon can be used to serve as a way of assessing the security of machine learning and to predict whether or not the adversarial samples exists.

So, some researchers proposed quantitative security analysis and evaluation of ml algorithms in a adversarial env. 
![image-20180716002410135](https://lib.azfs.com.cn/2018-07-15-162410.png)
Fig. 5 illustrates an example of proactive security assessment considering data distributions.

First, select proper adversarial models with respect to the hypothesized attack scenario defined at the conceptual level by making assumptions on the goal, knowledge, capacity and corresponding strategy.

Then, it defines the distributions p(Y), p(A\|Y) and p(**X**\|Y, A) for training and testing data, where Y belongs to set {L, M} and A belongs to set {F, T} respectively refer to class labels (L:legitimate; M:malicious) and a Boolean random variable representing whether or not a given sample has been manipulated (A=T) or not(A=F).

After that, it constructs sample training **TR** and testing **TS** sets according to the data model defined before, given k>=1 Paris of data sets $(D_{TR}^I, D_{TS}^i), i=1,...,k$ that are obtained from classical `resampling` techniques, e.g., `cross-validation` or `bootstrapping`. Finally, the classifier performance with the presence of simulated attack is evaluated using the constructed(TR^i, TS^i) pairs.

#### 2. Countermeasures in Training phase

Two main countermeasures:

* Ensuing the purity of training data.
* Improving the robustness of learning algorithms.

**Data Sanitization** : ensuring the purity of training data by separating adversarial samples from normal ones, and then removing these malicious samples. E.g., Reject on Negative Impact(RONI) defense tested the impact of each email in the training phase and did not train on message that had a large negative impact. To quantitatively measure impacts on the classification performance, the method **compare error rate between the original classifier and the new one**, which was retrained after adding new samples into the original training data, over the same testing data. If the error rate of the new classifier was much lower than that of the original one, then the new added samples were considered as malicious data and would be removed from training data.

**Improving the robustness of learning algorithms** is another feasible defending technique, e.g., Bootstrap Aggregating and Random Subspace Method(RSM).

**Design secure learning algorithms**, for example, Demontis *et al.* proposed a defending method that improved the security of linear classifier by learning more evenly-distributed feature weights.

#### 3. Countermeasures in Testing/Inferring phase

Focus on the improvement of learning algorithms' robustness.

**Game theory**

Tho *et al.* proposed invariant SVM algorithms using the min-max method to address the worst case feature manipulation activities in the testing phase.

To improve the robustness, Scheffer *et al.* proposed Stackelberg Games for adversarial prediction problems and a nashSVM algorithm based on the Nash equilibrium. 

Bulo *et al.* extended previous work and proposed a randomized prediction game by considering randomized strategy selections according to some probability distribution defined over the respective strategy set. Results show that this method could improve the trade-off between attack detection and false alarms of classifiers.

**Active defense considering data distribution**

The goal of adversarial samples in the testing/Inferring phase is to alter data distribution of test data. So, a feasible way of defending against adversaries is to **fit the testing data distribution by `retraining` learning models** by classifier designers with adversarial samples. So that the new trained classifier are able to detect anomalies in the testing phase. 

**Smoothing model output**

Is also effective to strengthen the robustness of learning models.

To protect deep learning algorithms in adversarial settings, **`defensive distillation`** was proposed to defend against adversarial samples on DNNs. Papernot *et al.* analyzed the generalization and robustness properties of defensive distillation. Comparative results validated that the technique could effectively enhance the performance of two DNNs with different architectures to detect adversarial samples in terms of the success rate of adversarial sample crafting from 95.86%(87.89%) to 0.45%(5.11%) on the MINST(CIFAT-10) data set.

**`Dimension reduction`**: can be used to protect machine learning models from evasion attacks. This strategy aimed to enhance the resilience of classifiers by reducing the dimension of sample features.



#### 4. Data security and privacy

* **Differential Privacy**
* Homomorphic encryption
* Multi-party computation
* K-means clustering algorithms



### 5. Challenges and future opportunities 

Five notable trends on security threats and defensive techniques of machine learning

1. New security threats towards machine learning are constantly emerging.
2. Security assessment on machine learning based decision systems in adversarial environments becomes a prevailing research area.
3. Data privacy plays an important role in protecting the security of machine learning.
4. Secure deep learning is a new growth point in the ﬁeld of machine learning security.
5. Jointly optimizing security, generalization performance and overhead is required to design secure learning algorithms.

