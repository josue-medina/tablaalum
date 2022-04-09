//
//  VistaDetalladaViewController.swift
//  Tabla
//
//  Created by mac18 on 14/03/22.
//
import Foundation
import UIKit

class VistaDetalladaViewController: UIViewController {
    var alumno: Alumno?
    var color:UIColor?
    
    
    @IBOutlet weak var nombreAlumnoLabel: UILabel!
    @IBOutlet weak var calificacionAlumnoLabel: UILabel!
    @IBOutlet weak var recibirColor: UILabel!
    
    
    @IBOutlet weak var cambImagen: UIImageView!
    
    
    var recibirNombre: String?
    var recibirCalificacion: Int?
    var recibirImagen: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
       nombreAlumnoLabel.text = recibirNombre ?? ""
        calificacionAlumnoLabel.text = "\(String(describing: recibirCalificacion ?? 0))"
        
        //agregamos la condicion para obtener el color
        if(recibirCalificacion ?? 0 > 70){
            recibirColor.text = "FELICIDADES!"
            cambImagen.image=UIImage(named: "1")
            cambImagen.backgroundColor = .green
            
        }
        
        if(recibirCalificacion ?? 0 < 70){
            recibirColor.text = "TU CALIFICACION ES NO APROBATORIA"
            cambImagen.image=UIImage(named: "2")
            cambImagen.backgroundColor = .red
        }
    }
    
    
    
    

}
