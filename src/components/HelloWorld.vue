<script setup>
import { ref, watch } from 'vue';

const costo = ref([]);
const horasS = ref([]);
const existe = ref([]);
const materias = ref([]);
const materiasS = ref(""); 
const materiasNS = ref("");
const mostrarMaterias = ref(true);
const mostrarSeleccionadas = ref(true);
const mostrarH = ref(false);
const horario=ref([]);
const user=21011060;

// Obtener datos
const ingresar = async () => {
  try {
    let datosFrm = "";
    datosFrm = "usuario=" + user + "&contra=" + 12345;
    let datos = await (
      await fetch("http://localhost/CursoPHPLGV/ModuloWeb/php/control.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: datosFrm,
      })
    ).json();
    if (datos.mensaje) {
      existe.value = datos;
    } else alert(datos.status);
  } catch (error) {
    alert("Error al llamar al servidor");
    console.log(error);
  }
  obtenerhorario();
};


// Obtener materias desde el servidor
const obtenerMaterias = async () => {
  
  const url = new URL("http://localhost/CursoPHPLGV/ModuloWeb/php/control.php");
  try {
    const respuesta = await fetch(url, { method: "GET" });
    const resultado = await respuesta.json();
    materias.value = resultado;
  } catch (error) {
    console.log(error);
  }
};

const obtenerhorario = async () => {
  const url = new URL("http://localhost/CursoPHPLGV/ModuloWeb/php/control.php?horario=true&usuario="+user);
  try {
    const respuesta = await fetch(url, { method: "GET" });
    const resultado = await respuesta.json();
    if(resultado.mensaje=="true"){
    horario.value=resultado.materias_recibidas;
    console.log(horario);
    mostrarMaterias.value = false;
      mostrarSeleccionadas.value = false;
      mostrarH.value=true;
  }
    else{obtenerMaterias();}
    
  } catch (error) {
    console.log(error);
  }
};

 const inscribirse = async () => {
  const materias=costo.value.map(r => `"${r[1]}|${r[2]}"`); // Agregamos comillas alrededor

// Unimos en un solo string separado por comas y con paréntesis alrededor
const resultado = user+`,${materias.join(",")}`;
console.log(resultado);
  try {
    let datosFrm = "";
    datosFrm = "materias=" +(resultado);
    let datos = await (
      await fetch("http://localhost/CursoPHPLGV/ModuloWeb/php/control.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: datosFrm,
      })
    ).json();
    if (datos.mensaje) {
      console.log(datos.status);
      console.log(datos.materias_recibidas);
      alert("Materias agregadas correctamente");
      
      obtenerhorario();
    } else alert(datos.status);
  } catch (error) {
    
  }
};


// Verificar si la hora ya está en horasS
const checar = (hora) => {
  return horasS.value.includes(hora); // Verificar si la hora está en horasS
};


const actualizarConflic=(materiaLlegada)=>{
 const horaMateria = materiaLlegada[5];

    // Verificar si la hora está en el arreglo horasS
    if (horasS.value.includes(horaMateria)) {
    horasS.value.slice(horaMateria,1);
    }

};

// Manejo de selección de materias y actualización de horas
watch(materiasS, (nuevoValor) => {
  if (nuevoValor >= 0 && nuevoValor < materias.value.length) {
    const materiaSeleccionada = materias.value[nuevoValor];
    const horaMateria = materiaSeleccionada[5];

    // Verificar si la hora está en el arreglo horasS
    if (!horasS.value.includes(horaMateria)) {
      horasS.value.push(horaMateria); // Solo agregar si no existe
      costo.value.push(materiaSeleccionada); // Agregar la materia a costo
      materias.value.splice(nuevoValor, 1); // Eliminar la materia de la lista
      costo.value.sort((a, b) => a[0].localeCompare(b[0])); // Ordenar las materias
    }

    // Verifica si la materia seleccionada tiene un conflicto
    
  }
});

watch(materiasNS,(nombre)=>{
  let luis3=costo.value[nombre];
 
  materias.value.push(luis3);
  costo.value.splice(nombre, 1);
  const posicion = horasS.value.findIndex(elemento => elemento === luis3[5]);
  console.log(luis3[5]);
  console.log(horasS);
  horasS.value.splice(posicion,1);

console.log(horasS);
  

});

// Inicialización
ingresar();


</script>



<template>
  <div class="container" >
    <div style="margin-top: -5%;">
      <img src="http://localhost/CursoPHPLGV/ModuloWeb/img/SEP.png" alt="" />
    </div>
    <div style="color: black; text-align: left;">
      <h2>SISTEMA INTEGRAL DE GESTIÓN DE INFORMACIÓN</h2>
      <h3>
        {{ existe?.nombre ? existe.nombre.toUpperCase() : '' }} {{ existe?.apellido_paterno ? existe.apellido_paterno.toUpperCase() : '' }}
        {{ existe?.apellido_materno ? existe.apellido_materno.toUpperCase() : '' }}

      </h3>
      <h4>ESTUDIANTE DE LICENCIATURA</h4>
    </div>
    <h2 style="color: black;">Elegir horario del estudiante</h2>
    <div class="data-A">
      <table>
        <thead>
          <tr>
            <th colspan="12">Estudiante</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Numero de control</td>
            <td>{{ existe.numero_control }}</td>
            <td rowspan="7"><img src="" alt="Foto del estudiante" /></td>
          </tr>
          <tr>
            <td>Nombre</td>
            <td>
              {{ existe?.nombre ? existe.nombre.toUpperCase() : '' }} {{ existe?.apellido_paterno ? existe.apellido_paterno.toUpperCase() : '' }} {{ existe?.apellido_materno ? existe.apellido_materno.toUpperCase() : '' }}

            </td>
          </tr>
          <tr>
            <td>Carrera</td>
            <td>{{ existe.carrera }}</td>
          </tr>
          <tr>
            <td>Semestre Actual</td>
            <td>{{ existe.semestre_actual }}</td>
          </tr>
          <tr>
            <td>Periodo de ingreso</td>
            <td>{{ existe.periodo_ingreso }}</td>
          </tr>
          <tr>
            <td>Retícula</td>
            <td>{{ existe.reticula }}</td>
          </tr>
          <tr>
            <td>Módulo</td>
            <td>{{ existe.modulo }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <br />
    <div class="header">
      <h2>TUTOR</h2>
    </div>
    <h2 style="background-color: aliceblue;color: black;">
      {{ existe.NombreT.toUpperCase() }} {{ existe.ApellidoPT.toUpperCase() }}
      {{ existe.ApellidoMT.toUpperCase() }}
    </h2>

    <br /><br />
    <div class="materias-dis" v-if="mostrarMaterias">
    <table>
      <thead>
        <tr>
          <th>Seleccionar</th><th>CSVO</th><th>CLAVE</th><th>GRUPO</th><th>MATERIA</th><th>CATEDRÁTICO</th>
          <th>LUN</th><th>MAR</th><th>MIE</th><th>JUE</th><th>VIE</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(materia, index) in materias"
          :key="index"
          :class="{ conflict: checar(materia[5]) }"
        >
          <td><input type="radio" v-model="materiasS" :value="index" /></td>
          <td v-for="(data, i) in materia" :key="i">{{ data }}</td>
        </tr>
      </tbody>
    </table>
    </div>
    <div class="selected-container" v-if="mostrarSeleccionadas">
      <h3>Materias seleccionadas</h3>
      <table>
        <thead>
          <tr>
            <th>CSVO</th><th>CLAVE</th><th>GRUPO</th><th>MATERIA</th><th>CATEDRÁTICO</th>
            <th>LUN</th><th>MAR</th><th>MIE</th><th>JUE</th><th>VIE</th><th>ELiminar</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(c, ojala) in costo" :key="ojala">
            <td v-for="(data, i) in c" :key="i">{{ data }}</td>
            <td>  
              <input type="radio" v-model="materiasNS" :value="ojala"/>{{ ojala }}
            </td>
          </tr>
        </tbody>
      </table>
       <a href="#" class="btn" @click="inscribirse">Cargar</a>
    </div>

    <br />

    <div class="horario" v-if="mostrarH">
      <table>
  <thead>
    <tr>
      <th>No.Materia</th><th>CLAVE</th><th>GRUPO</th><th>MATERIA</th><th>CATEDRÁTICO</th>
      <th>LUN</th><th>Salon</th><th>MAR</th><th>Salon</th><th>MIE</th><th>Salon</th><th>JUE</th><th>Salon</th><th>VIE</th><th>Salon</th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="(a, j) in horario" :key="j">
      <td>{{ a[0] }}</td> <!-- No.Materia -->
      <td>{{ a[1] }}</td> <!-- Clave -->
      <td>{{ a[2] }}</td> <!-- Grupo -->
      <td>{{ a[3] }}</td> <!-- Materia -->
      <td>{{ a[4] }}</td> <!-- Catedrático -->
      <td>{{ a[5] }}</td><td>{{ a[10] }}</td> <!-- Lun y SalonLun -->
      <td>{{ a[6] }}</td><td>{{ a[11] }}</td> <!-- Mar y SalonMar -->
      <td>{{ a[7] }}</td><td>{{ a[12] }}</td> <!-- Mie y SalonMie -->
      <td>{{ a[8] }}</td><td>{{ a[13] }}</td> <!-- Jue y SalonJue -->
      <td>{{ a[9] }}</td><td>{{ a[14] }}</td> <!-- Vie y SalonVie -->
    </tr>
  </tbody>
</table>
    </div>
  </div>
</template>

<style>
body {
  font-family: Arial, sans-serif;
  background-color: #f9f9f9;
  text-align: center;
  color: #000;
}
.data-A {
  margin-left: 30%;
  table {
    width: 50%;
    height: 50%;
  }
  th {
    background-color: #001a94;
    color: white;
  }
  td {
    background-color: white;
    color: black;
  }
}
.data-A td:nth-child(1) {
  background-color: #001a94;
  color: white;
}
.container {
  width: 90%;
  margin: 20px auto;
}
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}
th,
td {
  border: 1px solid #000;
  padding: 8px;
  text-align: center;
  color: #000;
}
th {
  background-color: #001a94;
  color: white;
}
.header {
  background-color: #001a94;
  color: white;
  margin-bottom: 10px;
}
.btn {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #001a94;
  color: white;
  text-decoration: none;
  border-radius: 5px;
}
.selected-container {
  margin-top: 40px;
}
.conflict {
  background-color: #ff0000;
  pointer-events: none;;
}
</style>
