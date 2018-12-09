package co.com.helisa.sherlock;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/*
 * Descripcion : clase control que permite determinar si una cadena cumple
 *               con las condiciones para retornar yes o no
 * @author:    dsalazar
 * @since:     08-dic-2018
 * @version:   1.0               
 * */

@RestController
public class SherlockController {

    
    /*
     * Descripcion : metodo para determinar si el parametro de entrada cumple con la condicion
     * @author:    dsalazar
     * @since:     08-dic-2018
     * @version:   1.0
     * Note: modo de uso -> http://localhost:8080/sherlock?s=abcde 
     * */
	@RequestMapping("/sherlock")
    public String sherlock(@RequestParam(value="s", defaultValue="abcd") String s) {
		String respuesta;
		respuesta = isValid(s);
        return respuesta;
    }
	
	
	/*
	 * Descripcion metodo que valida la cadena 
	 * @author:    dsalazar
     * @since:     08-dic-2018
     * @version:   1.0   
	 * */
	private String isValid(String s){
        HashMap<Character, Integer> count_char = new HashMap<Character, Integer>();
        int del_count = 0;
        String result = "YES";

        for(int i = 0; i < s.length(); i++){
            if(count_char.containsKey(s.charAt(i))){
                count_char.put(s.charAt(i), count_char.get(s.charAt(i)) +1 );
            }else{
                count_char.put(s.charAt(i), 1);        
            }
        }
        int current = 0;
        for (Map.Entry<Character, Integer> count : count_char.entrySet()){
            if(current == 0){
                current = count.getValue();
            }else{
                int diff = Math.abs(current - count.getValue());
                if(count.getValue() > 1 && diff > 0){
                    del_count += diff;
                }else if(count.getValue() == 1 && diff > 0){
                    del_count++;
                }
            }
        }
        if(del_count > 1){
            result = "NO";
        }
        return result;
    }
}
