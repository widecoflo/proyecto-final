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
    public class PagosController : ControllerBase
    {
        private readonly string _connectionString;

        public PagosController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("conexion");
        }

        [HttpGet]
        public IEnumerable<Pagos> Get()
        {
            List<Pagos> pagos = new();
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("ListarPagos", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Pagos pago = new()
                            {
                                id_pago = Convert.ToInt32(reader["id_pago"]),
                                id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                monto = Convert.ToDecimal(reader["monto"]),
                                fecha_pago = Convert.ToDateTime(reader["fecha_pago"]),
                                tipo_pago = reader["tipo_pago"].ToString(),
                                comprobante_url = reader["comprobante_url"].ToString(),
                                estado = reader["estado"].ToString()
                            };
                            pagos.Add(pago);
                        }
                    }
                }
            }
            return pagos;
        }

        [HttpGet("{id}")]
        public Pagos Get(int id)
        {
            Pagos pago = null;
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("ObtenerPago_id", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_pago", id);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            pago = new Pagos
                            {
                                id_pago = Convert.ToInt32(reader["id_pago"]),
                                id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                monto = Convert.ToDecimal(reader["monto"]),
                                fecha_pago = Convert.ToDateTime(reader["fecha_pago"]),
                                tipo_pago = reader["tipo_pago"].ToString(),
                                comprobante_url = reader["comprobante_url"].ToString(),
                                estado = reader["estado"].ToString()
                            };
                        }
                    }
                }
            }
            return pago;
        }

        [HttpPost]
        public void Post([FromBody] Pagos pago)
        {
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("InsertarPago", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_miembro", pago.id_miembro);
                    cmd.Parameters.AddWithValue("@monto", pago.monto);
                    cmd.Parameters.AddWithValue("@fecha_pago", pago.fecha_pago);
                    cmd.Parameters.AddWithValue("@tipo_pago", pago.tipo_pago);
                    cmd.Parameters.AddWithValue("@comprobante_url", pago.comprobante_url);
                    cmd.Parameters.AddWithValue("@estado", pago.estado);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Pagos pago)
        {
            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new("ActualizarPago", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_pago", id);
                    cmd.Parameters.AddWithValue("@id_miembro", pago.id_miembro);
                    cmd.Parameters.AddWithValue("@monto", pago.monto);
                    cmd.Parameters.AddWithValue("@fecha_pago", pago.fecha_pago);
                    cmd.Parameters.AddWithValue("@tipo_pago", pago.tipo_pago);
                    cmd.Parameters.AddWithValue("@comprobante_url", pago.comprobante_url);
                    cmd.Parameters.AddWithValue("@estado", pago.estado);
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
                using (SqlCommand cmd = new("BorrarPago", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_pago", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}