## 关系代数作业

1. $$\Pi_{cid, aid, pid}(Customers\Join Agents\Join products)$$

2. $$\Pi_{cid,aid,pid}(\sigma_{Customers.city\ne Agents.city\and Agents.city\ne products.city \and products.city\ne Customers.city}(Customers\times Agents\times products))$$

3. $$\Pi_{Pname}(\sigma_{Customers.city='Hangzhou'\and Agents.city='Shanghai'}(Customers\times Agents\times products)\Join Orders)$$

4. $$A1 = Agents, A2=Agents$$

   $$\Pi_{A1.aid,A2.aid}(\sigma_{A1.city=A2.city\and A1.aid\ne A2.aid}(A1\times A2))$$

5. $$\Pi_{aname}(\Pi_{aid,pid}(Orders)\div \Pi_{pid}(\sigma_{cid='002'}(Orders))\Join Agents)$$

6. $$\Pi_{cid,aid,pid}(\sigma_{Customers.city=Agents.city\or Agents.city=products.city\or products.city=Customers.city}(Customers\times Agents\times products))$$

7. $$\Pi_{aid}(\sigma_{price\times Qty \gt 500}((\sigma_{Customers.city='Shanghai'}(Customers)\Join Orders)\Join products))$$

8. $$O1=Orders, O2=Orders$$

   $$\Pi_{cid}(Orders)-\Pi_{cid}(\sigma_{O1.cid=O2.cid\and O1.aid\ne O2.aid}(O1\times O2))$$

## 课本 p70

6. (1). $$\Pi_{SNO}(\sigma_{JNO='J1'}(SPJ))$$

   (2). $$\Pi_{SNO}(\sigma_{JNO='J1'\and PNO='P1'}(SPJ))$$

   (3). $$\Pi_{SNO}(\Pi_{SNO,PNO}(\sigma_{JNO='J1'}(SPJ))\Join \Pi_{PNO}(\sigma_{COLOR='红'}(P)))$$

   (4). $$\Pi_{JNO}(J)-\Pi_{JNO}(\Pi_{SNO}(\sigma_{CITY='天津'}(S))\Join \Pi_{SNO,PNO,JNO}(SPJ))$$

   (5). $$\Pi_{JNO,PNO}(SPJ)\div \Pi_{PNO}(\sigma_{SNO='S1'}(SPJ))$$

7. 它们是连接运算中两种最为重要也最为常用的连接。

   自然连接是一种特殊的等值连接，它要求两个关系中进行比较的分量，即连接属性必须是相同的属性组，并且要在结果中去掉其中一个重复属性。

8. 关系代数基本运算：并、差、笛卡尔积、投影、选择。

   交：$R\cap S=R-(R-S)$

   连接：$R\Join_{A\theta B} S=\sigma_{A\theta B}(R\times S)$

   除：$R(X,Y)\div S(Y,Z)=\Pi_X(R)-\Pi_X(\Pi_X(R)\times\Pi_Y(S)-R)$