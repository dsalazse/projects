package co.com.helisa.nondivisible;

import java.util.*;

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
public class NonDivisibleSubsetController {

    
    /*
     * Descripcion : metodo para determinar si el parametro de entrada cumple con la condicion
     * @author:    dsalazar
     * @since:     08-dic-2018
     * @version:   1.0
     * Note: modo de uso -> http://localhost:8080/nonDivisibleSubset?k=3&S=1 7 2 4 
     * */
	@RequestMapping("/nonDivisibleSubset")
    public int nonDivisibleSubset(@RequestParam(value="k") int k,
    						  @RequestParam(value="S") int [] S) {
		int resultado=respuesta(k,S);
        return resultado;
    }
	
	
	/*
	 * Descripcion metodo que valida la cadena 
	 * @author:    dsalazar
     * @since:     08-dic-2018
     * @version:   1.0   
	 * */
	private int respuesta(int k,int [] S){
		List<Integer> lstInt = new ArrayList<>(S.length);
        for (int i=0; i<S.length; i++) {
        	lstInt.add(S[i]);
        }

        int[] mods = new int[k];
        int mod;
        for (Integer e : lstInt) {
            mod = e%k;
            mods[mod] = mods[mod] + 1;
        }

        int count = 0;
        if (mods[0] > 0) {
            mods[0] = 1;
            count++;
        }
        int mid = k >> 1;
        if ((k&0x01) == 0) {
            mods[mid] = mods[mid] > 0 ? 1 : 0;
        }

        for (int i=1; i<=mid; i++) {
            count += mods[i] > mods[k-i] ? mods[i] : mods[k-i];
        }

        return count;

    }
}
