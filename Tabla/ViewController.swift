//
//  ViewController.swift
//  Tabla
//
//  Created by mac18 on 14/03/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablaItems: UITableView!
    
    //var alumnos = ["robert, josue, carlos"]
    //var calif = [100, 70, 69]
    var alumnoSeleccionado: String?
    var alumnoSeleccionado2: Int?
    
    var alumnos = [Alumno(nombre: "roberto", calificacion: 100),
                   Alumno(nombre: "josue", calificacion: 90),
                   Alumno(nombre: "carlos", calificacion: 67)
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tablaItems.delegate = self
        tablaItems.dataSource = self
    }
    
    
    @IBAction func agregarNuevoBtn(_ sender: UIBarButtonItem) {
        
        let alerta = UIAlertController(title: "Nuevo contacto", message: "Agregar", preferredStyle: .alert)
        
        //crear el textField
        alerta.addTextField { nombreAlerta in
            nombreAlerta.placeholder = "Escribe un nuevo alumno"
        }
        //crea otro textFiel para la calificacion
        
        alerta.addTextField{ calificacionesAlerta in
            calificacionesAlerta.placeholder = "ingresar calificacion"
            calificacionesAlerta.keyboardType = .numberPad
        }
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default){_ in
            print("Alumno agregado")
            //guard let es una variable segura
            guard let nombreAlumno = alerta.textFields?.first?.text else {return}
            guard let calificacionAlumno = alerta.textFields?[1].text else {return}
            //crear nuevo obj Alumno
            let nuevoAlumno = Alumno(nombre: nombreAlumno, calificacion: Int(calificacionAlumno) ?? 0)
            self.alumnos.append(nuevoAlumno)
            print(self.alumnos)
            //actualiza la tabla
            self.tablaItems.reloadData()
        }
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated: true, completion: nil)
        
    }
    

    // MARK: METODOS DE LA UITABLEVIEW
    //retorna el número de renglones de mi lista
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumnos.count
    }
    
    //creo mi obj de tipo celda y la retorno
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //crear un obj de tipo UITableViewCell
        let celda = tablaItems.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        celda.textLabel?.text = alumnos[indexPath.row].nombre
        print(alumnos[indexPath.row])
        
       celda.detailTextLabel?.text = "14 de marzo 2022"
        return celda
        
    }
    
    //Identifica que elementos se esta seleccionando
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(alumnos[indexPath.row])
        //obtenemos el nombre del alumno
        alumnoSeleccionado = alumnos[indexPath.row].nombre
        //obtenermos ahora la calif
        alumnoSeleccionado2 = alumnos[indexPath.row].calificacion
        
        //Mandar elemento seleccionado al 2do viewcontroller
        performSegue(withIdentifier: "enviarNombre", sender: self)
        //performSegue(withIdentifier: "enviarCalificacion", sender: self)
    }
    
    //metodo para eliminar
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("Nombre eliminado")
            alumnos.remove(at: indexPath.row)
            print(alumnos)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviarNombre"{
            let objDestino = segue.destination as! VistaDetalladaViewController
            objDestino.recibirNombre = alumnoSeleccionado
            objDestino.recibirCalificacion = alumnoSeleccionado2
        }
    }


}
