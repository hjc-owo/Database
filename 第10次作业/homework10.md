## p202

1. 描述定义：

   1. 函数依赖：设关系模式$R(U,F)$，$U$是属性全集，$F$是$U$上的函数依赖集，$X$和$Y$是$U$的子集，如果对于$R(U)$的任意一个可能的关系$r$，对于$X$的每一个具体值，$Y$都有唯一的具体值与之对应，则称$X$决定函数$Y$，或$Y$函数依赖于$X$，记作$X\rightarrow Y$。我们称$X$为决定因素，$Y$为依赖因素。当$Y$不函数依赖于$X$时，记作：$X\nrightarrow Y$。当$X\rightarrow Y$且$Y\rightarrow X$时，则记作：$X\leftrightarrow Y$。

   2. 完全函数依赖与部分函数依赖：设关系模式$R(U)$，$U$是属性全集，$X$和$Y$是$U$的子集。如果$X\rightarrow Y$，并且对于$X$的任何一个真子集$X^{′}$，都有$X^{′} \nrightarrow Y$，则称$Y$对$X$完全函数依赖(Full Functional Dependency)，记作$X \xrightarrow{f} Y$。如果对$X$的某个真子集$X^{′}$，有$X^{′} \rightarrow Y$，则称$Y$对部分函数依赖(Partial Functional Dependency)，记作$X\xrightarrow{p} Y$。

   3. 传递依赖：设有关系模式$R(U)$，$U$是属性全集，$X$，$Y$，$Z$是$U$的子集，若$X\rightarrow Y$，但$Y\nrightarrow X$，而$Y\rightarrow Z(Y\notin X,Z\notin Y)$，则称$Z$对$X$传递函数依赖(Transitive Functional Dependency)，记作：$X \xrightarrow{t} Z$。如果$Y\rightarrow X$，则$X\leftrightarrow Y$，这时称$Z$对$X$直接函数依赖，而不是传递函数依赖。

   4. 候选键、超键和主键：设$K$为关系模式$R<U,F>$中的属性或属性组合。若$K \xrightarrow{f} U$，则$K$称为$R$的一个候选键(Candidate Key)。若关系模式$R$有多个候选键，则选定其中的一个做为主键(Primary key)。若$k$是$R$的一个候选键，并且$S\supset K$，则称$S$是$R$的一个超键 (Super Key)。

   5. 外键：关系模式$R$中属性或属性组$X$并非$R$的候选键，但$X$是另一个关系模式的候选键，则称$X$是$R$的外键(Foreign key)。

   6. 全键：整个属性组是键，称为全键。

   7. 1NF：如果关系模式$R$，其所有的属性均为简单属性，即每个属性域都是不可再分的，则称$R$属于第一范式，简称1NF，记作$R\in 1$NF。

   8. 2NF：如果关系模式$R\in 1$NF，且每个非主属性都完全函数依赖于$R$的每个关系键，则称R属于第二范式(Second Normal Form)，简称2NF，记作$R\in 2$NF。

   9. 3NF：如果关系模式$R\in 2$NF，且每个非主属性都不传递依赖于$R$的每个关系键，则称$R$属于第三范式(Third Normal Form)，简称3NF，记作$R\in 3$NF。

   10. BCNF：如果关系模式$R\in 1$NF，且所有的函数依赖$X\rightarrow Y(Y\notin X)$，决定因素$X$都包含了$R$的一个候选键，则称$R$属于BC范式 (Boyce-Codd Normal Form)，记作$R\in$BCNF。



7. 判断正误。

   1. 任何一个二元关系是3NF的。(T)
   
   2. 任何一个二元关系是BCNF的。(T)