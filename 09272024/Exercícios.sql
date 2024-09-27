# Utilizar subquery para encontrar um funcionario com salário maior #
# Que o funcionário de ID = 1 #
SELECT id_funcionario "Código", f.nome "Nome", f.salario, "Salário"
FROM funcionarios
WHERE salario > (SELECT salario
		FROM funcionarios
		WHERE id_funcionario = 1)
		
# Utilizar o operador IN pode me trazer uma tabela como resultado #
# Utilizando para encontrar funcionários que possuem salário maior #
# que o funcionário de ID = 1 e que fazem parte do projeto com ID = 3 #

SELECT id_funcionario "Código funcionário", nome "Nome", salario "Salário"
FROM funcionarios
WHERE salario > (SELECT salario
		FROM funcionarios
		WHERE id_funcionario = 1)
AND id_funcionario IN (SELECT id_funcionario
			FROM funcionarios_projetos
			WHERE id_projeto = 3)
			
# Listar os funcionários cujo valor do salário é igual 
# ao maior salário cadastrado na empresa.

SELECT id_funcionario "Código", nome "Nome", salario "Salário"
FROM funcionarios
WHERE salario = (SELECT MAX(salario)
		FROM funcionarios)
		
# Listar os funcionários cujo valor do salário é igual 
# ao menor salário cadastrado na empresa.

SELECT id_funcionario "Código", nome "Nome", salario "Salário"
FROM funcionarios
WHERE salario = (SELECT MIN(salario)
		FROM funcionarios)
		
#Listar todos os funcionários que possuem salários 
#abaixo da média dos salários entre todos os funcionários 
#da empresa

SELECT id_funcionario "Código", nome "Nome", salario "Salário"
FROM funcionarios
WHERE salario < (SELECT AVG(salario)
		FROM funcionarios)
		
#Query para reajustar em 10% o salario de 
#todos os funcionarios com numero de dependentes maior 
#do que 2.

UPDATE funcionarios
SET salario = salario * 1.10
WHERE id_funcionario IN (
			SELECT id_funcionario
			FROM dependentes
			GROUP BY id_funcionario
			HAVING COUNT(id_dependente) > 2)
			
#Liste todos os dependentes que possuem idade maior #
#ou igual a idade média de todos os dependentes cadastrados #
#na empresa. #

SELECT id_dependente "Código", nome "Nome", sexo "Sexo",YEAR(CURRENT_DATE) - YEAR(DATAN) "Idade"
FROM dependentes
WHERE YEAR(CURRENT_DATE) - YEAR(DATAN) >= (SELECT AVG(YEAR(CURRENT_DATE) - YEAR(DATAN))
					   FROM dependentes)
					   
#Lista os departamentos que possuem 2 ou mais funcionários #

# Código | Descritivo

SELECT id_departamento "Código", descritivo "Descritivo"
FROM departamentos
WHERE id_departamento IN (
			  SELECT id_departamento
			  FROM funcionarios
			  GROUP BY id_departamento
			  HAVING COUNT(id_funcionario) >= 2
			  )