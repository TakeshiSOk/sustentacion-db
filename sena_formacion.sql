USE sena_formacion;

CREATE TABLE MODALIDAD (
    id_modalidad     INT          NOT NULL AUTO_INCREMENT,
    nombre_modalidad VARCHAR(80)  NOT NULL,
    descripcion      VARCHAR(200),
    es_virtual       TINYINT(1)   NOT NULL DEFAULT 0,
    horas_semanales  INT          NOT NULL DEFAULT 0,
    CONSTRAINT PK_MODALIDAD PRIMARY KEY (id_modalidad)
);

CREATE TABLE INSTRUCTOR (
    id_instructor INT          NOT NULL AUTO_INCREMENT,
    documento     VARCHAR(20)  NOT NULL,
    nombres       VARCHAR(80)  NOT NULL,
    apellidos     VARCHAR(80)  NOT NULL,
    email         VARCHAR(100) NOT NULL,
    especialidad  VARCHAR(100),
    tipo_contrato VARCHAR(50),
    CONSTRAINT PK_INSTRUCTOR PRIMARY KEY (id_instructor)
);

CREATE TABLE PROGRAMA (
    id_programa     INT          NOT NULL AUTO_INCREMENT,
    codigo_programa VARCHAR(20)  NOT NULL,
    nombre_programa VARCHAR(150) NOT NULL,
    nivel_formacion VARCHAR(50)  NOT NULL,
    duracion_horas  INT          NOT NULL DEFAULT 0,
    fecha_inicio    DATE,
    fecha_fin       DATE,
    id_modalidad    INT          NOT NULL,
    id_instructor   INT          NOT NULL,
    CONSTRAINT PK_PROGRAMA   PRIMARY KEY (id_programa),
    CONSTRAINT FK_PROG_MODAL FOREIGN KEY (id_modalidad)  REFERENCES MODALIDAD(id_modalidad),
    CONSTRAINT FK_PROG_INSTR FOREIGN KEY (id_instructor) REFERENCES INSTRUCTOR(id_instructor)
);

CREATE TABLE APRENDIZ (
    id_aprendiz   INT          NOT NULL AUTO_INCREMENT,
    documento     VARCHAR(20)  NOT NULL,
    nombres       VARCHAR(80)  NOT NULL,
    apellidos     VARCHAR(80)  NOT NULL,
    email         VARCHAR(100) NOT NULL,
    telefono      VARCHAR(15),
    fecha_ingreso DATE         NOT NULL,
    CONSTRAINT PK_APRENDIZ PRIMARY KEY (id_aprendiz)
);

CREATE TABLE COMPETENCIA (
    id_competencia     INT          NOT NULL AUTO_INCREMENT,
    codigo_norma       VARCHAR(20)  NOT NULL,
    nombre_competencia VARCHAR(150) NOT NULL,
    horas_asignadas    INT          NOT NULL DEFAULT 0,
    creditos           INT          NOT NULL DEFAULT 0,
    CONSTRAINT PK_COMPETENCIA PRIMARY KEY (id_competencia)
);

CREATE TABLE MATRICULA (
    id_matricula    INT         NOT NULL AUTO_INCREMENT,
    id_aprendiz     INT         NOT NULL,
    id_programa     INT         NOT NULL,
    fecha_matricula DATE        NOT NULL,
    estado          VARCHAR(20) NOT NULL DEFAULT 'Activo',
    CONSTRAINT PK_MATRICULA    PRIMARY KEY (id_matricula),
    CONSTRAINT FK_MAT_APRENDIZ FOREIGN KEY (id_aprendiz) REFERENCES APRENDIZ(id_aprendiz),
    CONSTRAINT FK_MAT_PROGRAMA FOREIGN KEY (id_programa) REFERENCES PROGRAMA(id_programa)
);

CREATE TABLE PROGRAMA_COMPETENCIA (
    id_programa    INT NOT NULL,
    id_competencia INT NOT NULL,
    CONSTRAINT PK_PROG_COMP   PRIMARY KEY (id_programa, id_competencia),
    CONSTRAINT FK_PC_PROGRAMA FOREIGN KEY (id_programa)    REFERENCES PROGRAMA(id_programa),
    CONSTRAINT FK_PC_COMP     FOREIGN KEY (id_competencia) REFERENCES COMPETENCIA(id_competencia)
);