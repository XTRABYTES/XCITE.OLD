/**
 * Filename: transaction.cpp
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2019 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

#include <iostream>

#include <boost/algorithm/string.hpp>

#include "transaction.h"

class CScriptVisitor : public boost::static_visitor<bool>
{
private:
    CScript *script;
public:
    CScriptVisitor(CScript *scriptin) { script = scriptin; }

    bool operator()(const CNoDestination &dest) const {
        script->clear();
        return false;
    }

    bool operator()(const CKeyID &keyID) const {
        script->clear();
        *script << OP_DUP << OP_HASH160 << keyID << OP_EQUALVERIFY << OP_CHECKSIG;
        return true;
    }

    bool operator()(const CScriptID &scriptID) const {
        script->clear();
        *script << OP_HASH160 << scriptID << OP_EQUAL;
        return true;
    }
};


void CScript::SetDestination(const CTxDestination& dest)
{
    boost::apply_visitor(CScriptVisitor(this), dest);
}

bool SignSignature(const CScript& fromPubKey, CTransaction& txTo, unsigned int nIn, const std::string &privkey)
{
	CTxIn& txin = txTo.vin[nIn];
	uint256 hash = SignatureHash(fromPubKey, txTo, nIn );
   return Solver(fromPubKey, hash, txin.scriptSig, privkey);		
}

uint256 SignatureHash(CScript scriptCode, const CTransaction& txTo, unsigned int nIn )
{
	CTransaction txTmp(txTo);
   scriptCode.FindAndDelete(CScript(OP_CODESEPARATOR));

   for (unsigned int i = 0; i < txTmp.vin.size(); i++)
        txTmp.vin[i].scriptSig = CScript();
   txTmp.vin[nIn].scriptSig = scriptCode;

    int nHashType = 1;
    CHashWriter ss(SER_GETHASH, 0);
    ss << txTmp << nHashType;
    return ss.GetHash();
}



bool Solver(const CScript& scriptPubKey, uint256 hash, CScript& scriptSigRet, const std::string &privkey)
{
	scriptSigRet.clear();
   std::vector<std::vector<unsigned char>> vSolutions;
   if (!PubkeyHashSolver(scriptPubKey, vSolutions)) return false;
   
   CXCiteSecret xciteSecret;
   bool fGood = xciteSecret.SetString(privkey,35);
   if (!fGood) return false;
   CKey key = xciteSecret.GetKey();
   
   
   std::vector<unsigned char> vchSig;
   if (!key.Sign(hash, vchSig)) return false;
   int nHashType=1;
   vchSig.push_back((unsigned char)nHashType);
   scriptSigRet << vchSig;   
            
   CPubKey vch = key.GetPubKey();

   scriptSigRet << vch;
   return true;
}


bool PubkeyHashSolver(const CScript& scriptPubKey, std::vector<valtype>& vSolutionsRet) {

    const CScript& script1 = scriptPubKey;
    const CScript script2 = CScript() << OP_DUP << OP_HASH160 << OP_PUBKEYHASH << OP_EQUALVERIFY << OP_CHECKSIG;

    vSolutionsRet.clear();

    opcodetype opcode1, opcode2;
    std::vector<unsigned char> vch1, vch2;

    CScript::const_iterator pc1 = script1.begin();
    CScript::const_iterator pc2 = script2.begin();
    
    for( ; ; )  {
      if (pc1 == script1.end() && pc2 == script2.end())  return true;
            
      if (!script1.GetOp(pc1, opcode1, vch1))  break;
      if (!script2.GetOp(pc2, opcode2, vch2))  break;

            if (opcode2 == OP_PUBKEYHASH)
            {
                if (vch1.size() != sizeof(uint160))
                    break;
                vSolutionsRet.push_back(vch1);
            }
            else if (opcode1 != opcode2 || vch1 != vch2) break;
        }

    vSolutionsRet.clear();
    return false;
    
}

std::string CreateRawTransaction(const std::vector<std::string> &inputs, const std::vector<std::string> &outputs, const std::string &privkey ) {

      CTransaction rawTx;       
 
      BOOST_FOREACH(const std::string input, inputs) {
      	
         std::vector<std::string> input_details;
         boost::split(input_details, input, [](char c){return c == ',';});

         uint256 txid;
         txid.SetHex(input_details.at(0));
        
         int nOutput = std::stoi(input_details.at(1));

         CTxIn in(COutPoint(txid, nOutput));
         rawTx.vin.push_back(in);
      } 
 

      BOOST_FOREACH(const std::string output, outputs) {

         std::vector<std::string> output_details;
         boost::split(output_details, output, [](char c){return c == ',';});
      	
         CXCiteAddress address(output_details.at(0),35);  // 35 = XFUEL network    	
      	CScript scriptPubKey;
         scriptPubKey.SetDestination(address.Get());
         // *** fixmee!! int64 nAmount = AmountFromValue(output_details.at(1));
         int64 nAmount = std::stoi(output_details.at(1));
         nAmount = nAmount * 100000000;

         CTxOut out(nAmount, scriptPubKey);
         rawTx.vout.push_back(out);
      }     
                  
      std::vector<CTransaction> txVariants;
      txVariants.push_back(rawTx);
      CTransaction mergedTx(txVariants[0]);
      
      for (unsigned int i = 0; i < mergedTx.vin.size(); i++) {
      	
      	const std::string input = inputs[i];
      	std::vector<std::string> input_details;
      	boost::split(input_details, input, [](char c){return c == ',';});
      	      	
         CTxIn& txin = mergedTx.vin[i];      
         txin.scriptSig.clear();
         std::vector<unsigned char> prevPubKeyBin = ParseHexcstr(input_details.at(2).c_str());                           
         const CScript prevPubKey(prevPubKeyBin.begin(), prevPubKeyBin.end());
      
         SignSignature(prevPubKey, mergedTx, i, privkey);
      
      }


      CDataStream ssTx(SER_NETWORK, PROTOCOL_VERSION);
      ssTx << mergedTx;
      return HexStr(ssTx.begin(), ssTx.end());

}