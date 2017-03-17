//
//  ViewController.swift
//  Z7_Coresample
//
//  Created by vera_john on 16/03/17.
//  Copyright © 2017 VERA. All rights reserved.
//

import UIKit
import CoreData
import Toaster

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var telefono: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sendPhone(_ sender: Any) {
        let tel = telefono.text! as String
        
        if tel != ""{
            print(tel)
            self.getJson(telefon: tel);
        }else{
            print("Introduzca número celular")
            showmessage(message: "Introduzca número celular");
        }
        
        //call class to get json
        //let task = Task()
    }
    
    //function to shoe toast
    func showmessage(message: String){
        
        Toast(text: message).show()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Termina edicion
        self.view.endEditing(true)
    }
    
    //Cuando das clic en return dek teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

    //Function to get data with the celphone
    func getJson(telefon:String){
        print("Here")
        let url = URL(string: "http://192.168.1.109:1000/api/InfoClientMobil/Celphone/5534959778")!
        
        let session = URLSession.shared;
        
        let loadTask = session.dataTask(with: url){(data,response,error) in
            if error != nil{
                print(error!)
            } else{
                if let urlContent = data{
                    
                    do{
                        let json = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //let json = try? JSONSerialization.jsonObject(with: urlContent, options: [])
                        //print(json)
                        
                        //print(json)
                        /*let json2 = String(describing: json)
                         let newString = json2.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
                         let newString2 = newString.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
                         print(newString2)*/
                        
                        //let json2:String = "{\"id\": 24, \"name\": \"Bob Jefferson\", \"friends\": [{\"id\": 29, \"name\": \"Jen Jackson\"}]}"
                        
                        //let current = json.value(forKey: "Client") as! [String:Any]
                        //print(current)
                        
                        //let location = ((json["("] as? NSArray)?[0] as? NSDictionary)?["Client"] as? String
                        
                        //let arreglo = json.values(forAttributes: ["Policies"])
                        //necesito los parametros del array de polizas
                        /*let jokes = json.dictionaryWithValues(forKeys: ["Client"])
                         print(jokes)
                         
                         let cosita = jokes["Client"] as! NSArray
                         print(cosita)
                         
                         let co = cosita.count
                         print(co)
                         
                         let mini = cosita[0]
                         print(mini)*/
                        
                        
                        /*for object in datos {
                         // access all objects in array
                         print(object)
                         print("----")
                         }
                         
                         let id = polizas.value(forKey: "Coverage")
                         print(id)*/
                        
                        //print(location)
                        /*if let dictionary = json as? [String: Any] {
                         print(dictionary)
                         for (key, value) in dictionary {
                         // access all key / value pairs in dictionary
                         print(key)
                         print("-----------")
                         print(value)
                         print("***********")
                         }
                         }*/
                        
                        //if let descripton = ((json["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                        //print(descripton)
                        /*DispatchQueue.main.sync(execute:{
                         self.result.text = descripton
                         })*/
                        //}
                        
                        //store do core data
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate // UIApplication.shared().delegate as! AppDelegate is now UIApplication.shared.delegate as! AppDelegate
                        
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                        
                        /*
                        newUser.setValue("b", forKey: "celphone")
                        newUser.setValue(21, forKey: "id")
                        newUser.setValue("a", forKey: "lastname")
                        newUser.setValue("c", forKey: "mothername")
                        newUser.setValue("bastar", forKey: "name")
                        newUser.setValue("d", forKey: "token")
                        */
                        
                        let cliente = json.value(forKey: "Client") as! NSArray
                        print(cliente)
                        let cli = cliente[0] as! NSDictionary
                        print(cli)
                        print(cli.count)
                        
                        //managedObject Core Data
                        /*for (key,value) in cli{
                            print("key: \(key) => value: \(value)")
                            let llave = String(describing: key).lowercased()
                            
                            if value == nil {
                                newUser.setValue("", forKey: llave)
                            }else if(llave == "id"){
                                newUser.setValue(value, forKey: llave)
                            }else{
                                var valor = String(describing:value)
                                newUser.setValue(valor, forKey: llave)
                            }
                        }
                        
                        do {
                            
                            try context.save()
                            
                            print("Saved")
                            
                        } catch {
                            
                            print("There was an error")
                            
                        }*/
                        
                        
                        //let polizas = json.value(forKey: "Policies") as! NSArray
                        
                        //get ans show data from CoreData
                        
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                        
                        //Delete items from CoreData
                        //let fetch = NSBatchDeleteRequest(fetchRequest: request)
                        //let result = try context.execute(fetch)
                        //print(result)
                        //request.predicate = Predicate(format: "username = %@", "ralphie")
                        
                        request.returnsObjectsAsFaults = false
                        
                        do {
                            
                            let results = try context.fetch(request)
                            
                            if results.count > 0 {
                                
                                for result in results as! [NSManagedObject] {
                                    
                                    if let username = result.value(forKey: "name") as? String {
                                        
                                        print(username)
                                        print(result.value(forKey: "lastname") as? String!)
                                        print(result.value(forKey: "mothername") as? String)
                                        print(result.value(forKey: "id") as? Int)
                                        /*
                                         
                                         context.delete(result)
                                         
                                         do {
                                         
                                         try context.save()
                                         
                                         } catch {
                                         
                                         print("Delete failed")
                                         
                                         }
                                         
                                         
                                         result.setValue("Dooley", forKey: "username")
                                         
                                         do {
                                         
                                         try context.save()
                                         
                                         } catch {
                                         
                                         print("Rename failed")
                                         
                                         }
                                         
                                         */
                                        
                                        
                                        
                                    }
                                    
                                }
                                
                                
                            } else {
                                
                                print("No results")
                                
                            }
                            
                            
                        } catch {
                            
                            print("Couldn't fetch results")
                            
                        }
                        
                    } catch{
                        print("Json process fail")
                    }
                }
            }
        }
        
        loadTask.resume()
    }

}

