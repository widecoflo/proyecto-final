using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using backendColegioProfesional.Models;

namespace backendColegioProfesional.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuariosController : ControllerBase
    {
        private readonly string _connectionString;

        public UsuariosController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("conexion");
        }

        [HttpGet]
        public IEnumerable<Usuarios> Get()
        {
            List<Usuarios> usuarios = new();
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("ListarUsuarios", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Usuarios usuario = new()
                            {
                                id_usuario = Convert.ToInt32(reader["id_usuario"]),
                                id_miembro = reader["id_miembro"] as int?,
                                username = reader["username"].ToString(),
                                password_hash = reader["password_hash"].ToString(),
                                rol = reader["rol"].ToString(),
                                fecha_creacion = reader["fecha_creacion"] as DateTime?,
                                ultimo_acceso = reader["ultimo_acceso"] as DateTime?
                            };
                            usuarios.Add(usuario);
                        }
                    }
                }
            }
            return usuarios;
        }

        [HttpGet("{id}")]
        public Usuarios Get(int id)
        {
            Usuarios usuario = null;
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("ObtenerUsuario_id", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario", id);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            usuario = new Usuarios
                            {
                                id_usuario = Convert.ToInt32(reader["id_usuario"]),
                                id_miembro = reader["id_miembro"] as int?,
                                username = reader["username"].ToString(),
                                password_hash = reader["password_hash"].ToString(),
                                rol = reader["rol"].ToString(),
                                fecha_creacion = reader["fecha_creacion"] as DateTime?,
                                ultimo_acceso = reader["ultimo_acceso"] as DateTime?
                            };
                        }
                    }
                }
            }
            return usuario;
        }

        [HttpPost]
        public void Post([FromBody] Usuarios usuario)
        {
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("InsertarUsuario", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_miembro", usuario.id_miembro);
                    cmd.Parameters.AddWithValue("@username", usuario.username);
                    cmd.Parameters.AddWithValue("@password_hash", usuario.password_hash);
                    cmd.Parameters.AddWithValue("@rol", usuario.rol);
                    cmd.Parameters.AddWithValue("@fecha_creacion", usuario.fecha_creacion);
                    cmd.Parameters.AddWithValue("@ultimo_acceso", usuario.ultimo_acceso);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Usuarios usuario)
        {
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("ActualizarUsuario", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario", id);
                    cmd.Parameters.AddWithValue("@id_miembro", usuario.id_miembro);
                    cmd.Parameters.AddWithValue("@username", usuario.username);
                    cmd.Parameters.AddWithValue("@password_hash", usuario.password_hash);
                    cmd.Parameters.AddWithValue("@rol", usuario.rol);
                    cmd.Parameters.AddWithValue("@fecha_creacion", usuario.fecha_creacion);
                    cmd.Parameters.AddWithValue("@ultimo_acceso", usuario.ultimo_acceso);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("BorrarUsuario", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}