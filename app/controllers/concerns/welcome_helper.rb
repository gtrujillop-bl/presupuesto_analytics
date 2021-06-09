module WelcomeHelper

  def metricas_presupuestos
    ['presupuesto_inicial', 'disponibilidad_total', 'reserva_total', 'egreso_total']
  end

  def chart_background_color
    ['rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(175, 214, 255, 0.2)',
    'rgba(255, 255, 0, 0.2)',
    'rgba(0, 250, 109, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(255, 255, 112, 0.2)',
    'rgba(255, 159, 64, 0.2)',
    'rgba(255, 128, 0, 0.2)',
    'rgba(255, 205, 86, 0.2)',
    'rgba(255, 0, 0, 0.2)',
    'rgba(201, 203, 207, 0.2)',
    'rgba(0, 0, 255, 0.2)']
  end

  def chart_border_color
    ['rgb(255, 99, 132)',
    'rgb(54, 162, 235)',
    'rgb(75, 192, 192)',
    'rgb(175, 214, 255)',
    'rgb(255, 255, 0)',
    'rgb(0, 250, 109)',
    'rgb(153, 102, 255)',
    'rgb(255, 206, 86)',
    'rgb(255, 255, 112)',
    'rgb(255, 159, 64)',
    'rgb(255, 128, 0)',
    'rgb(255, 205, 86)',
    'rgb(255, 0, 0)',
    'rgb(201, 203, 207)',
    'rgb(0, 0, 255)']
  end

  def chart_hex_color
    ["#25CCF7","#FD7272","#54a0ff","#00d2d3",
    "#1abc9c","#2ecc71","#3498db","#9b59b6","#34495e",
    "#16a085","#27ae60","#2980b9","#8e44ad","#2c3e50",
    "#f1c40f","#e67e22","#e74c3c","#ecf0f1","#95a5a6",
    "#f39c12","#d35400","#c0392b","#bdc3c7","#7f8c8d",
    "#55efc4","#81ecec","#74b9ff","#a29bfe","#dfe6e9",
    "#00b894","#00cec9","#0984e3","#6c5ce7","#ffeaa7",
    "#fab1a0","#ff7675","#fd79a8","#fdcb6e","#e17055",
    "#d63031","#feca57","#5f27cd","#54a0ff","#01a3a4"]
  end
  
  def stacked_bar_opts
    {
      stacked: true, 
      responsive: true, 
      scales: {
        xAxes: [{
          stacked: false,
          gridLines: {
            display: true,
          },
          scaleLabel: { 
            display: true, 
            fontSize: 10, 
          } 
        }],
        yAxes: [{
          stacked: false,
          ticks: {
            beginAtZero: true,
            callback: 'function(value, index, values) {
              return "$" + value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
            }'
          },
          type: 'linear',
          scaleLabel: {

          }
        }]
      }, 
      legend: { position: 'bottom' },
      maintainAspectRatio: false,
      tooltips: {
        enabled: true,
        callbacks: {
          label: 'function(tooltipItem) {
            return "$" + tooltipItem.yLabel.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
          }'
        }
      }
    }
  end
  
  def horizontal_bar_opts
    {
      responsive: true, 
      scales: {
        yAxes: [{
          stacked: true,
          gridLines: {
            display: true,
          },
          scaleLabel: { 
            display: true, 
            fontSize: 10, 
          } 
        }],
        xAxes: [{
          stacked: true,
          ticks: {
            beginAtZero: true,
            callback: 'function(value, index, values) {
              return "$" + value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
            }'
          },
          type: 'linear',
          scaleLabel: {

          }
        }]
      }, 
      legend: {
        position: 'top',
        labels: {
          fontColor: 'rgb(255, 99, 132)',
          strokeStyle: '#000000',
          fillStyle: '#000000',
        }
      },
      maintainAspectRatio: false,
      tooltips: {
        enabled: true,
        callbacks: {
          label: 'function(tooltipItem) {
            return "$" + tooltipItem.xLabel.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
          }'
        }
      }
    }
  end

  def doughnut_chart_opts
    {
      stacked: true,
      aspectRatio: 2,
      responsive: true,
      legend: { position: 'bottom' },
      maintainAspectRatio: true,
      tooltips: {
        enabled: true
      }
    }
  end

  def line_chart_opts
    {
      stacked: true, 
      responsive: true, 
      lineTension: 0.1,
      scales: {
        xAxes: [{
          stacked: false,
          gridLines: {
            display: true,
          },
          scaleLabel: { 
            display: true, 
            fontSize: 10, 
          } 
        }],
        yAxes: [{
          stacked: false,
          ticks: {
            beginAtZero: true
          },
          type: 'linear',
          scaleLabel: {

          }
        }]
      },
      legend: { position: 'top' },
      maintainAspectRatio: false,
      tooltips: {
        enabled: true
      }
    }
  end

  def radar_chart_opts
    {
      stacked: true, 
      responsive: true,
      elements: {
        line: {
          borderWidth: 1
        }
      },
      scales: {
        xAxes: [{
          stacked: false,
          gridLines: {
            display: true,
          },
          scaleLabel: { 
            display: true, 
            fontSize: 10, 
          } 
        }],
        yAxes: [{
          stacked: false,
          ticks: {
            beginAtZero: true,
            callback: 'function(value, index, values) {
              return "$" + value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
            }'
          },
          type: 'linear',
          scaleLabel: {

          }
        }]
      }, 
      legend: { position: 'top' },
      maintainAspectRatio: true,
      tooltips: {
        enabled: true,
        callbacks: {
          label: 'function(tooltipItem) {
            return "$" + tooltipItem.yLabel.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
          }'
        }
      }
    }
  end

  private

  
end
