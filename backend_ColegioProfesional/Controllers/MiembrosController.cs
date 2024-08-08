using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace backendColegioProfesional.Models
{
    [ApiController]
    [Route("api/[controller]")]
    public class MiembrosController : ControllerBase
    {
        public readonly string con;
        public MiembrosController(IConfiguration configuration)
        {
            con=configuration.GetConnectionString("conexion");
        }

        [HttpGet]
            public IEnumerable<Miembros> Get()
            {
                List<Miembros> miembros = new();
                using (SqlConnection connection = new(con))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("ListarMiembros", connection))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Miembros miembro = new Miembros
                                {
                                    id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                    dni = reader["dni"].ToString(),
                                    nombres = reader["nombres"].ToString(),
                                    apellidos = reader["apellidos"].ToString(),
                                    fecha_nacimiento = Convert.ToDateTime(reader["fecha_nacimiento"]),
                                    direccion = reader["direccion"].ToString(),
                                    email = reader["email"].ToString(),
                                    telefono = reader["telefono"].ToString(),
                                    universidad = reader["universidad"].ToString(),
                                    titulo = reader["titulo"].ToString(),
                                    fecha_graduacion = reader["fecha_graduacion"] as DateTime?,
                                    foto_url = reader["foto_url"].ToString(),
                                    estado = reader["estado"].ToString(),
                                    fecha_registro = reader["fecha_registro"] as DateTime?
                                };

                                miembros.Add(miembro);
                            }
                        }
                    }
                }
                return miembros;
            }

           [HttpGet("{id}")]
            public Miembros Get(int id)
            {
                Miembros miembro = null;
                using (SqlConnection connection = new(con))
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("ObtenerMiembro_id", connection))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@id_miembro", id);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                miembro = new Miembros
                                {
                                    id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                    dni = reader["dni"].ToString(),
                                    nombres = reader["nombres"].ToString(),
                                    apellidos = reader["apellidos"].ToString(),
                                    fecha_nacimiento = Convert.ToDateTime(reader["fecha_nacimiento"]),
                                    direccion = reader["direccion"].ToString(),
                                    email = reader["email"].ToString(),
                                    telefono = reader["telefono"].ToString(),
                                    universidad = reader["universidad"].ToString(),
                                    titulo = reader["titulo"].ToString(),
                                    fecha_graduacion = reader["fecha_graduacion"] as DateTime?,
                                    foto_url = reader["foto_url"].ToString(),
                                    estado = reader["estado"].ToString(),
                                    fecha_registro = reader["fecha_registro"] as DateTime?
                                };
                            }
                        }
                    }
                }
                return miembro;
            }

             [HttpPost]
                public void Post([FromBody] Miembros miembro)
                {
                    using (SqlConnection connection = new(con))
                    {
                        connection.Open();
                        using (SqlCommand cmd = new SqlCommand("InsertarMiembro", connection))
                        {
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@dni", miembro.dni);
                            cmd.Parameters.AddWithValue("@nombres", miembro.nombres);
                            cmd.Parameters.AddWithValue("@apellidos", miembro.apellidos);
                            cmd.Parameters.AddWithValue("@fecha_nacimiento", miembro.fecha_nacimiento);
                            cmd.Parameters.AddWithValue("@direccion", miembro.direccion);
                            cmd.Parameters.AddWithValue("@email", miembro.email);
                            cmd.Parameters.AddWithValue("@telefono", miembro.telefono);
                            cmd.Parameters.AddWithValue("@universidad", miembro.universidad);
                            cmd.Parameters.AddWithValue("@titulo", miembro.titulo);
                            cmd.Parameters.AddWithValue("@fecha_graduacion", miembro.fecha_graduacion);
                            cmd.Parameters.AddWithValue("@foto_url", miembro.foto_url);
                            cmd.Parameters.AddWithValue("@estado", miembro.estado);
                            cmd.Parameters.AddWithValue("@fecha_registro", miembro.fecha_registro);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                [HttpPut("{id}")]
                public void Put(int id, [FromBody] Miembros miembro)
                {
                    using (SqlConnection connection = new(con))
                    {
                        connection.Open();
                        using (SqlCommand cmd = new SqlCommand("ActualizarMiembro", connection))
                        {
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@id_miembro", id);
                            cmd.Parameters.AddWithValue("@dni", miembro.dni);
                            cmd.Parameters.AddWithValue("@nombres", miembro.nombres);
                            cmd.Parameters.AddWithValue("@apellidos", miembro.apellidos);
                            cmd.Parameters.AddWithValue("@fecha_nacimiento", miembro.fecha_nacimiento);
                            cmd.Parameters.AddWithValue("@direccion", miembro.direccion);
                            cmd.Parameters.AddWithValue("@email", miembro.email);
                            cmd.Parameters.AddWithValue("@telefono", miembro.telefono);
                            cmd.Parameters.AddWithValue("@universidad", miembro.universidad);
                            cmd.Parameters.AddWithValue("@titulo", miembro.titulo);
                            cmd.Parameters.AddWithValue("@fecha_graduacion", miembro.fecha_graduacion);
                            cmd.Parameters.AddWithValue("@foto_url", miembro.foto_url);
                            cmd.Parameters.AddWithValue("@estado", miembro.estado);
                            cmd.Parameters.AddWithValue("@fecha_registro", miembro.fecha_registro);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                 [HttpDelete("{id}")]
                    public void Delete(int id)
                    {
                        using (SqlConnection connection = new(con))
                        {
                            connection.Open();
                            using (SqlCommand cmd = new SqlCommand("BorrarMiembro", connection))
                            {
                                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@id_miembro", id);
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
    }
}