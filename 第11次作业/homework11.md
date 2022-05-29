2. 设计数据库

   1. 关系模式

      - 学生$S(SNO, SN, SB, DN, CNO, SA)$
      - 班级$C(CNO, CS, DN, CNUM, CDATE)$
      - 系$D(DNO, DN, DA, DNUM)$
      - 学会$P(PN, DATE1, PA, PNUM)$
      - 学生-学会$SP(SNO, PN, DATE2)$

      其中，$SNO$学号，$SN$姓名，$SB$出生年月，$SA$宿舍区

      $CNO$班号，$CS$专业名，$CNUM$班级人数，$CDATE$入校年份

      $DNO$系号，$DN$系名，$DA$系办公室地点，$DNUM$系人数

      $PN$学会名，$DATE1$成立年月，$PA$地点，$PNUM$学会会员人数

      $DATE2$入会年份

   2. 每个关系模式的极小函数依赖集

      - $S: SNO\rightarrow SN, SNO \rightarrow SB, SNO\rightarrow CNO, CNO\rightarrow DN, DN\rightarrow SA$
      - $C: CNO\rightarrow CS, CNO\rightarrow CNUM, CNO\rightarrow CDATE, CS\rightarrow DN, (CS,CDATE)\rightarrow CNO$
      - $D: DNO\rightarrow DN, DN\rightarrow DNO, DNO\rightarrow DA, DNO\rightarrow DNUM$
      - $P: PN\rightarrow DATE1, PN\rightarrow PA, PN\rightarrow PNUM$
      - $SP: (SNO, PN)\rightarrow DATE2$

   3. $S$中存在的函数依赖：

      - 因为$SNO\rightarrow CNO, CNO\rightarrow DN$，所以$SNO\rightarrow DN$
      - 因为$CNO\rightarrow DN, DN\rightarrow SA$，所以$CNO\rightarrow SA$
      - 因为$SNO\rightarrow CNO, CNO\rightarrow DN, DN\rightarrow SA$，所以$SNO\rightarrow SA$

   4. $C$中存在的函数依赖

      - 因为$CNO\rightarrow CS, CS\rightarrow DN$，所以$CNO\rightarrow DN$

   5. 函数依赖左部是所属性的情况

      - $(CS,CDATE)\rightarrow CNO, (SNO, PN)\rightarrow DATE2$都是完全函数依赖，不存在部分函数依赖的情况

   6. | 关系 | 候选键               | 外键      | 全键 |
      | ---- | -------------------- | --------- | ---- |
      | $S$  | $SNO$                | $CNO, DN$ | 无   |
      | $C$  | $CNO$和$(CS, CDATE)$ | $DN$      | 无   |
      | $D$  | $DNO$和$DN$          | 无        | 无   |
      | $P$  | $PN$                 | 无        | 无   |
      | $SP$ | $(SNO, PN)$          | $SNO, PN$ | 无   |

7. 判断正误

   5. 若$R.A \rightarrow R.B, R.B\rightarrow R.C$，则$R.A\rightarrow R.C$ (T)

   6. 若$R.A \rightarrow R.B, R.A\rightarrow R.C$，则$R.A\rightarrow R(B,C)$ (T)

   7. 若$R.B\rightarrow R.A, R.C\rightarrow R.A$，则$R(B,C)\rightarrow R.A$ (T)

   8. 若$R(B,C)\rightarrow R.A$，则$R.B\rightarrow R.A, R.C\rightarrow R.A$ (F)
   
      反例：关系模式$SC(SNO,CNO,G),(SNO,CNO)\rightarrow G$，但是$SNO\nrightarrow G, CNO\nrightarrow G$