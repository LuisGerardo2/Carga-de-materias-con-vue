<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");


include("conn.php");

// 1. Manejar preflight CORS

function obtenerMaterias($sentencia) {
    global $con;  // Esto hace que $con sea accesible dentro de la función
    $sql = "SELECT materia.*, maestros.nombre as nombreC, maestros.apellido_paterno as apc, maestros.apellido_materno as apm 
            FROM materia 
            INNER JOIN maestros ON maestros.id_maestro = materia.catedratico WHERE $sentencia
            ORDER BY materia.Lun;";
    $resultado = $con->query($sql);
    $index = 0;

    if ($resultado->num_rows > 0) {
        $materias = [];
        while ($row = $resultado->fetch_assoc()) {
            $salonesD = explode(",", $row['salones']);
            $horarios = ["lun", "mar", "mie", "jue", "vie"];
            foreach ($salonesD as $S => $salon) {
                $nombre = "S" . strval($index);
                $row[$nombre] = $salon;
                $index++;
            }
            $horario_dia = [];
            foreach ($horarios as $dia) {
                $horario_dia[] = $row[$dia] ?? "";
            }
            $catedratico = [$row['nombreC'] . " " . $row['apc'] . " " . $row['apm']];
            $materias[] = [
                str_pad(count($materias) + 1, 3, '0', STR_PAD_LEFT),
                $row['clave'],
                $row['grupo'],
                strtoupper($row['materia']),
                ...$catedratico,
                ...$horario_dia,    
                ...$salonesD
            ];
        }
        return $materias;
    } else {
        return json_encode([]);  // También importante devolver algo si no hay resultados
    }
}

// 2. Manejar POST login
if ( isset($_REQUEST["usuario"]) && !empty($_REQUEST["usuario"]) &&
    isset($_REQUEST["contra"]) && !empty($_REQUEST["contra"])) {
    
    $sql = "SELECT estudiantes.*, maestros.nombre as NombreT,maestros.apellido_paterno as ApellidoPT,maestros.apellido_materno as ApellidoMT 
            FROM estudiantes 
            INNER JOIN maestros ON maestros.id_maestro = estudiantes.tutor 
            WHERE estudiantes.numero_control = " . $_REQUEST['usuario'] . " 
            AND contrasena = " . $_REQUEST['contra'] . ";";
    $resultado = $con->query($sql);
    
    if ($resultado->num_rows == 1) {
        $alumno = $resultado->fetch_assoc();
        $alumno['mensaje'] = true;
        echo json_encode($alumno);
    } else {
        echo json_encode(["mensaje" => "Usuario o contraseña incorrectos"]);
    }
    exit();
}


if (isset($_REQUEST["materias"]) && !empty($_REQUEST["materias"])) {

    $materias=$_POST["materias"];
    // Obtenemos el string enviado
     // No necesitamos convertirlo, ya lo envias como string con los paréntesis
     $valoresContados = substr_count($materias, ",") + 1;

// Si faltan valores, agregarlos
if ($valoresContados < 10) {
    $faltantes = 10 - $valoresContados;
    $materias .= str_repeat(", NULL", $faltantes);
}

// Ahora colocar paréntesis
$sql = "INSERT INTO `horario`(`id_a`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `nada`) VALUES ($materias);";
    
    $resultado = $con->query($sql);
    
    if ($resultado) {
        echo json_encode([
            "mensaje" => "true",
            "status" => "ok",
            "materias_recibidas" => $materias
        ]);
    } else {
        echo json_encode([
            "mensaje" => "error",
            "status" => "Error al insertar: " . $con->error
        ]);
    }
    exit();
}


// 4. Manejar GET materias
if ($_SERVER['REQUEST_METHOD'] == 'GET' && empty($_REQUEST['horario'])) {
    $sql = "SELECT materia.*, maestros.nombre as nombreC, maestros.apellido_paterno as apc, maestros.apellido_materno as apm 
            FROM materia 
            INNER JOIN maestros ON maestros.id_maestro = materia.catedratico 
            ORDER BY materia.Lun;";
    $resultado = $con->query($sql);
    $index = 0;
    
    if ($resultado->num_rows > 0) {
        $materias = [];
        while ($row = $resultado->fetch_assoc()) {
            $salonesD = explode(",", $row['salones']);
            $horarios = ["lun", "mar", "mie", "jue", "vie"];
            foreach ($salonesD as $S => $salon) {
                $nombre = "S" . strval($index);
                $row[$nombre] = $salon;
                $index++;
            }
            $horario_dia = [];
            foreach ($horarios as $dia) {
                $horario_dia[] = $row[$dia] ?? "";
            }
            $catedratico = [$row['nombreC'] . " " . $row['apc'] . " " . $row['apm']];
            $materias[] = [
                str_pad(count($materias) + 1, 3, '0', STR_PAD_LEFT),
                $row['clave'],
                $row['grupo'],
                strtoupper($row['materia']),
                ...$catedratico,
                ...$horario_dia
                //...$salonesD
            ];
        }
        echo json_encode($materias);
    } else {
        echo json_encode(["mensaje" => "No hay materias registradas"]);
    }
    exit();
}


if (isset($_REQUEST["horario"]) && !empty($_REQUEST["horario"]) && isset($_REQUEST["usuario"]) && !empty($_REQUEST["usuario"])) {
    $user=$_GET['usuario'];
$sql = "SELECT * from horario WHERE id_a=$user";
    $resultado = $con->query($sql);
    $index = 0;
    
    if ($resultado->num_rows > 0) {
        $materias = [];
        $partesM=[];
        $stringQL="";
        $row = $resultado->fetch_assoc();

        for($i=0;$i<8;$i++){
                $materias[]=explode("|",$row["materia".($i+1)]);
                $stringQL=$stringQL."(clave='".$materias[$i][0]."' && grupo='".$materias[$i][1]."')";
                if($i<7){
                    $stringQL=$stringQL." OR ";
                }
                
        }
        $partesM=obtenerMaterias($stringQL);
        foreach ($partesM as &$materia) {  // Usamos referencia para modificar directamente
    foreach ($materia as &$dato) {
        if (is_null($dato) || $dato == "NULL" || trim($dato) == "") {
            $dato = "-";
        }
    }
}
        echo json_encode([
            "mensaje" => "true",
            "status" => "ok",
            "materias_recibidas" => $partesM
        ]);
    
    }
     else {
        echo json_encode([
            "mensaje" => "error",
            "status" => "Error al insertar: " . $con->error
        ]);
    }
    exit();
}
// 5. Si no coincide ningún método, devuelve error

exit();
?>
